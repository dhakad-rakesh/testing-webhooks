class MatchSerializer < BaseSerializer
  attributes :id, :uid, :status, :name, :market, :participants, :market_counts, :current_period, :streaming_url
  attribute :schedule_at, unless: '!!instance_options.fetch(:score, false)'
  attribute :score #, if: '!!instance_options.fetch(:score, false)'
  attribute :running_time #, if: '!!instance_options.fetch(:score, false)'
  # attribute :qualifier, if: '!!instance_options.fetch(:score, false)'
  attribute :statistics, if: 'instance_options.fetch(:statistics, true)'
  attribute :markets, if: 'instance_options.fetch(:markets, true)'
  attribute :main_markets, if: 'instance_options.fetch(:main_markets, true)'
  has_one :venue
  attribute :teams
  attribute :tournament
  belongs_to :sport
  # belongs_to :tournament

  def name
    object.title 
  end

  def market
    #fulltime result market ids
    # fulltime_result_market_id = object.is_live? ? "1777" : "1"
    fulltime_result_market_id = "1"
    market_id = @instance_options.fetch(:market_id, false) || fulltime_result_market_id
    if SportMarket.disabled_sport_markets_ids(sport_id: object.sport_id).include?(market_id)
      {}
    else
      Utility::MarketUtility.identifier_data(object.id, market_id, "49")
    end
  end

  def teams
    object.teams.map do |team|
      TeamSerializer.new(team, include: [], event: object, scope: current_user, scope_name: 'current_user', sport: false, qualifier: true)
    end
  end

  def participants
    object.name&.split(' vs ')&.map(&:strip)
  end

  # def markets
  #   object.arrange_markets_by_ranking
  # end

  # Depreciate above markets method
  def markets
    object.group_markets_by_category
  end

  def running_time
    object.running_time.blank? ? 'NA' : object.running_time
  end

  def score
    object.score.blank? ? 'NA' : object.score
  end

  def tournament
    TournamentSerializer.new(object.tournament, scope_name: :current_user)
  end
end
