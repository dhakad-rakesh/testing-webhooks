class Api::FavouritesController < Api::BaseController
  before_action :resource, only: %I[create]
  before_action :set_favourite, only: :destroy
  after_action :update_topic_subscription

  def create
    return render_not_found_response(I18n.t('favourite.resource_not_found')) unless @favouriteable_id
    outcomes = Favourites.run(favouriteable_type: @favouriteable_type, favouriteable_id: @favouriteable_id,
                              user: current_user, is_default: favourite_params[:is_default])
    return render_success_response(I18n.t('favourite.marked')) if outcomes.valid?
    render_error_response(outcomes.errors.full_messages.first)
  end

  def destroy
    return render_success_response(I18n.t('favourite.destroy')) if @favourite.destroy
    render_error_response(@favourite.errors.full_messages.first)
  end

  private

  def resource
    @favouriteable_id = sport || team || tournament
  end

  def sport
    return if favourite_params[:sport_id].blank?
    @favouriteable_type = 'Sport'
    favourite_params[:sport_id]
  end

  def team
    return if favourite_params[:team_id].blank?
    @favouriteable_type = 'Team'
    favourite_params[:team_id]
  end

  def tournament
    return if favourite_params[:tournament_id].blank?
    @favouriteable_type = 'Tournament'
    favourite_params[:tournament_id]
  end

  def favourite_params
    params.permit(:sport_id, :team_id, :tournament_id, :id, :is_default)
  end

  def set_favourite
    @favourite = Favourite.where(id: favourite_params[:id], user_id: current_user.id).first
    return render_not_found_response(I18n.t('favourite.not_found')) if @favourite.blank?
  end

  def update_topic_subscription
    return unless team
    topic = "#{Constants::FAVOURITE_TEAM_TOPIC}_#{team}"
    if params[:action] == 'create'
      # TODO: Named parameters
      UpdateTopicSubscriptionJob.perform_later(topic, current_user.device_ids, nil)
    else
      UpdateTopicSubscriptionJob.perform_later(topic, nil, current_user.device_ids)
    end
  end
end
