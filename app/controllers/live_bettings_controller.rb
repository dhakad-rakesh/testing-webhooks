class LiveBettingsController < BaseController
  layout 'user_theme'
  skip_before_action :authenticate_user!
  before_action :set_favorite_ids, only: [:index, :add_favorite, :remove_favorite, :events_list]
  before_action :set_match, only: [:add_favorite, :remove_favorite]
  before_action :set_live_matches, only: [:index, :events_list]

  def index
    @upcoming_event_count = upcoming_matches.count
    @favorite_event_count = favorite_matches.count
    @live_matches = unfavorite_live_matches
    @live_event_count = @live_matches.count
    @live_matches = @live_matches.group_by(&:sport)
  end

  def add_favorite
    @favorite_ids << @match.id
    Rails.cache.write("live_favorite_matches_#{request.remote_ip}", @favorite_ids)
    render json: { message: 'Match added to your favourite.', status: 200 }
  end

  def remove_favorite
    @favorite_ids.delete(@match.id)
    Rails.cache.write("live_favorite_matches_#{request.remote_ip}", @favorite_ids)
    render json: { message: 'Match removed from your favourite.', status: 200 }
  end

  def events_list
    case params[:kind]
    when "upcoming"
      @events = upcoming_matches
    when "favorite"
      @events = favorite_matches
    else
      @events = unfavorite_live_matches
    end 
    @events = @events.group_by(&:sport)
    respond_to do |format|
      format.js
    end
  end

  private

  def set_favorite_ids
    @favorite_ids = Rails.cache.fetch("live_favorite_matches_#{request.remote_ip}") || []
  end

  def set_live_matches
    @live_matches = Match.active_with_live_matches
  end

  def set_match
    @match = Match.find_by_id(params[:match_id]&.to_i)
  end

  def unfavorite_live_matches
    @live_matches.where.not(id: @favorite_ids).chronological_order_on_time
  end

  def upcoming_matches
    Match.upcoming.schedulable.limit(10)
  end

  def favorite_matches
    @live_matches.where(id: @favorite_ids).chronological_order_on_time
  end
end