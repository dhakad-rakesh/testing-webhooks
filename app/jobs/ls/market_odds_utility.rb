require 'sidekiq-limit_fetch'

module LS
  module MarketOddsUtility
    def process_and_update_cache(data)
      return if data[:Markets].blank?
      market_uids = data[:Markets].pluck(:Id)
      # odds_data = match.odds_data(market_uids)
      # We do not need to read. This complexity can be delegate to single market job
      # odds_data = OddStore.new(match_uid).get_multiple_markets(market_uids)
      odds_data = { markets: {} }
      
      updated_markets = { markets: {} }

      data[:Markets].each do |market|
        if odds_data[:markets][market['Id'].to_s].present?
          market_data = odds_data[:markets][market['Id'].to_s]['49']
          market_status = []
          provider = format_match_bets(market[:Providers])
          next if provider.blank?
          market_data, market_status = update_odds_by_bets_data(market_data, provider, market_status)
          # Sorting for existing markets
          # order_outcomes(market_data, market['Id'].to_s) if Constants::MARKET_OUTCOME_ORDER.keys.include?(market['Id'].to_s)

          market_data[:status] = market_status.uniq.join(', ')
          # update cache
          # old_data = Rails.cache.fetch(Utility::Cache.odds_change_cache_key(match.id)) || { markets: {} }
          # old_data[:markets][market['Id'].to_s]['49'] = market_data
          updated_markets[:markets][market['Id'].to_s] = { '49' => market_data}
        else
          # Push new market
          market_data = formated_match_markets(Array.wrap(market), match_uid)

          next if market_data[market[:Id].to_s].blank?

          # old_data = Rails.cache.fetch(Utility::Cache.odds_change_cache_key(match.id)) || { markets: {} }
          # old_data[:markets].merge!(market_data)
          updated_markets[:markets].merge!(market_data)
        end

        # Removing prematch markets
        # check_if_market_suspended(id, old_data)

        # Rails.cache.write(Utility::Cache.odds_change_cache_key(match.id), old_data)
      end
      # binding.pry
      publish_odd_updates(match_uid, updated_markets)
      # update_match(match)
      write_to_cache_store(match_uid, updated_markets)
    end

    def order_outcomes(market_data, market_id)
      ordered_bets = {}
      bets = market_data[:outcomes]
      Constants::MARKET_OUTCOME_ORDER[market_id][:ls_outcomes_name].select{ |outcome| ordered_bets.merge!(bets.select { |k,v| v[:name] == outcome }) }
      market_data[:outcomes] = ordered_bets
    end

    def update_odds_by_bets_data(market_data, provider, market_status)
      provider['Bets'].each do |bet|
        bet_status = Bet.ls_status(bet['Status'])
        market_status << bet_status
        if market_data[:outcomes][bet['Id'].to_s].present?
          market_data[:outcomes][bet['Id'].to_s][:odds] = bet['Price']
          market_data[:outcomes][bet['Id'].to_s][:status] = bet_status
          # market_data[:outcomes][bet["Id"].to_s][:handicap] = bet['BaseLine'] if bet['BaseLine'].present?
          market_data[:outcomes][bet['Id'].to_s][:last_update] =  bet['LastUpdate']
        else
          # Append new outcome to market
          market_data[:outcomes][bet[:Id].to_s] = format_outcome(bet)
        end
        update_handicaps(market_data, bet[:Id].to_s)
      end
      [market_data, market_status]
    end

    def format_outcome(bet)
      { uid: bet[:Id].to_s, odds: bet[:Price], name: bet[:Name], handicap: bet[:BaseLine], status: Bet.ls_status(bet[:Status]), last_update: bet[:LastUpdate] }
    end

    def format_match_bets(providers)
      # Filter bets by provider, ex: Bet365
      # Lsports::Format::InplayOdds.new.match_bets(bets)
      # As we received one provider at one time
      provider = providers[0]
      return provider if provider[:Name] == 'Bet365'

      nil
    end

    # Uncomment below methods to replace overall market cache
    # def process_and_update_cache(data)
    #   odds_data = match.odds_data
    #   formated_match_markets(data[:Markets]).each do |market_id, market|
    #     odds_data[:markets][market_id] = market # Replace overall market
    #   end
    #   update_cache(odds_data)
    # end

    def formated_match_markets(markets, match_uid)
      Lsports::Format::InplayOdds.new.match_markets(markets, match_uid)
    end

    # def update_cache(data)
    #   store_data_in_cache(data)
    # end

    def update_match(match)
      match.enable unless match.enabled?
    end

    def refector_markets(cache_data)
      # Suspend short time markets
      Constants::SHORT_TIME_MARKETS.map { |m| cache_data[:markets][m]['49'][:status] = 'suspended' if cache_data[:markets][m] } if match.disable_st_markets?
      # Suspend half time markets
      Constants::HALF_TIME_42_MARKETS.map { |m| cache_data[:markets][m]['49'][:status] = 'suspended' if cache_data[:markets][m] } if match.disable_ht_markets?
      # Suspend all markets
      cache_data[:markets].keys.map { |m| cache_data[:markets][m]['49'][:status] = 'suspended' } if match.disable_all_inplay_markets?

      cache_data
    end

    def check_if_market_suspended(id, cache_data)
      return false if sport.uid != '6046' || match.not_started?

      # (Constants::SHORT_TIME_MARKETS.include?(id) && match.disable_st_markets?) || (Constants::HALF_TIME_42_MARKETS.include?(id) && match.disable_ht_markets?) || match.disable_all_inplay_markets?
      if match.disable_prematch_markets?
        prematch_markets = cache_data[:markets].keys & Constants::LS_PREMATCH_MARKETS
        prematch_markets.map { |m| cache_data[:markets][m]['49'][:status] = 'suspended' if cache_data[:markets][m] }
      end
    end

    def update_handicaps(market_data, bet_id)
      return if market_data[:handicaps] == -1
      outcome = market_data[:outcomes][bet_id]
      market_data[:handicaps][outcome[:handicap]] ||= {}
      market_data[:handicaps][outcome[:handicap]]["-#{outcome[:uid]}"] = outcome
    end

    # TODO: Delegate this responsibility to a separate service
    def write_to_cache_store(match_uid, markets)
      # if OddStoreService.odd_store == :redis
        update_single_markets(match_uid, markets)
      # elsif OddStoreService.odd_store == :cloud_firestore
      #   OddStore.new(match_uid).odds_data = markets
      # else
      #   push_to_dynamic_queue(match, markets)
      # end
    end

    def push_to_dynamic_queue(match, markets)
      queue_name = "odds_#{match.uid}"
          Sidekiq::Client.push('queue' => queue_name,
            'class' => 'LS::UpdateMarketsInCacheJob',
            'args' => [match.uid, markets]
          )
      Sidekiq::Queue[queue_name].limit = 1
    end

    def update_single_markets(match_uid, markets)
      markets[:markets].each do |market_uid, market_data|
        unique_id = "#{match_uid}_#{market_uid}"
        LS::UpdateSingleMarketJob.perform_async(match_uid, market_uid, market_data, unique_id)
      end
    end
  end
end
