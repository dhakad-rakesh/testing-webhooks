class Api::LedgersController < Api::BaseController
  # skip_before_action :check_country_status

  def index
    ledgers = current_user.ledgers.paginate(page: params[:page],
                                            per_page: params[:per_page])
    render_collection(ledgers)
  end
end
