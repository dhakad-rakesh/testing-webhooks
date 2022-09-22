class Admin::TopicsController < Admin::BaseController
  before_action :set_topic, only: %w[update]
  include Topics

  def index
    @topics = Topic.all
    @topics = @topics.paginate(page: params[:page])
  end

  def create
    Topic.new(name: params[:topic][:name]).save
    redirect_to admin_topics_path
  end

  def update
    return render json: { error: t('not_found', name: t('topic')) }, status: :not_found unless @topic
    return render json: { message: topic_status_message } if @topic&.update(update_params)
    render json: { error: @topic.errors.full_messages.first }, status: :bad_request
  end

  private

  def update_params
    params.permit(:enabled)
  end

  def set_topic
    @topic = Topic.find_by(id: params[:id])
  end

  def topic_status_message
    status = @topic.enabled ? 'enabled' : 'disabled'

    t(".message_#{status}", name: @topic.name)
  end
end
