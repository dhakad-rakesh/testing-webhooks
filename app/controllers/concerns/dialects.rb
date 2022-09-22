module Dialects
  extend ActiveSupport::Concern

  def index
    render json: Dialect.select(:id, :name).order(:name)
  end
end
