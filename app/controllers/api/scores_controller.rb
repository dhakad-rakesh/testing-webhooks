class Api::ScoresController < Api::BaseController
  def index
    render json: Match.live, score: true, include: %w[sport]
  end
end
