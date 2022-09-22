module Topics
  extend ActiveSupport::Concern

  def index
    render json: Topic.select(:id, :name, :enabled).order(created_at: :desc)
  end
end
