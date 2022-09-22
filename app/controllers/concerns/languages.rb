module Languages
  extend ActiveSupport::Concern

  def index
    render json: Language.select(:id, :name).order(:name)
  end
end
