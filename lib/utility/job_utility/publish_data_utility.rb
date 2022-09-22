module Utility::JobUtility::PublishDataUtility

  def publish_odd_updates(match_uid, data = {})
    # data = match.odds_data if data.blank?
    channel_name = Constants::ODDS_UPDATE_CHANNEL
    # publish_markets_for_testing(match, data[:markets], channel_name)
    data, top_markets = format_markets_data(data, match_uid)
    publish_data(match_uid, data, channel_name)
    # publish_data(match, top_markets, Constants::TOP_MARKETS_CHANNEL) if publish_to_top_markets_channel?(top_markets)
  end

  def publish_livescore(match)
    channel_name = Constants::SCORE_UPDATE_CHANNEL
    data = { 
      statistics: match.statistics, 
      current_period: match.current_period,
      running_score: match.try(:score),
      running_time: match.try(:running_time) 
    }
    publish_data(match.uid, data, channel_name)
  end

  def publish_status_updates(match)
    channel_name = Constants::STATUS_UPDATE_CHANNEL
    data = { 
      match_status: match.status,
      running_score: match.try(:score),
      running_time: match.try(:running_time)
    }
    publish_data(match.uid, data, channel_name)
  end

  def publish_data(match_uid, data, channel_name)
    Publishers::PublishData.run!(
      channel_name: "#{channel_name}/#{match_uid}", data: data
    )
  rescue Firebase::Exceptions::InvalidRequest
    # Publishers::PublishData.run!(
    #   channel_name: channel_name, data: {
    #     match => { message: 'pool', match_status: match.actual_status }
    #   }
    # )
    custom_error_logger(exception)
  rescue ::StandardError => e
    custom_error_logger(e) 
  end

  def publish_match_updates(match)
    PublishMatchUpdate.run!(match: match)
  end

  def custom_error_logger(exception)
    Honeybadger.notify(
      "[Firebase Error] : [#{exception.class}] : [#{exception.cause}]",
      class_name: exception.class
    )
  end

  def format_markets_data(markets, match_uid)
    if group_by_category?
      categorised_markets(markets, match_uid)
    else
      format_markets(markets, match_uid)
    end
  end

  # Adding static condition for fallback formatting 
  def group_by_category?
    ENV.fetch("GROUP_MARKETS_BY_CATEGORY", "true") == "true"
  end

  def format_markets(markets, match)
    top_markets = {}
    disabled_markets = fetch_disabled_markets(match.sport_id)
    markets[:markets].each do |_, market|
      if disabled_markets[market['49'][:uid]].present?
        market['49'][:disabled] = true
      else
        market['49'][:disabled] = false
      end
      if Constants.inplay_top_markets[match.sport.uid].keys.include?(market['49'][:uid].to_s)
        top_markets[market['49'][:uid]] = market
      end
    end
    [markets, top_markets]
  end

  def categorised_markets(markets, match_uid)
    markets = markets[:markets]  
    formatted_markets = {}
    top_markets = {}
    # disabled_markets = fetch_disabled_markets(match.sport_id)
    markets.each do |_, market|
      # if disabled_markets[market['49'][:uid]].present?
      #   market['49'][:disabled] = true
      # else
      #   market['49'][:disabled] = false
      # end

      market['49'][:categories].each do |_, category|
        formatted_markets[category] ||= {}
        formatted_markets[category][market['49'][:uid]] = market
      end

      # if Constants.inplay_top_markets[match.sport.uid].keys.include?(market['49'][:uid].to_s)
      #   top_markets[market['49'][:uid]] = market
      # end
    end
    data = { markets: formatted_markets }
    [data, top_markets]
  end

  def fetch_disabled_markets(id)
    disabled_markets = SportMarket.disabled_sport_markets_ids(sport_id: id)
    Hash[disabled_markets.zip disabled_markets]
  end

  def publish_markets_for_testing(match, data, channel_name)
    return unless testing_active?
    Publishers::Firebase::RealtimeDatabase::PublishData.run!(
      channel_name: "#{channel_name}/#{match.id}", data: data
    )
  rescue ::StandardError => e
    custom_error_logger(e) 
  end

  def testing_active?
    Rails.cache.read(:testing_status) || false
  end

  def publish_to_top_markets_channel?(top_markets)
    return false unless top_markets.present?
    FeatureTogglers::PublishToTopMarketsChannel::Toggler.activated?
  end
end
