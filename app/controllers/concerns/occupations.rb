module Occupations
  extend ActiveSupport::Concern

  def index
    render json: Occupation.select(:id, :name).order(:name)
  end
end
