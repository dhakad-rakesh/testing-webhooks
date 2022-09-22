class Api::Users::ReferralsController < Api::BaseController

  def index
    referrals = filtered_referrals.paginate(
      page: params[:page],
      per_page: params[:per_page]
    )
    render_collection(referrals)
  end

  protected

  # Use-case for JSON API Adapter to limit nested data
  def filtered_referrals
    current_user.referral_relations.includes(includes).public_send(status)
  end

  def includes
    [user: [:address, :wallets]]
  end

  def status
    Referral::STATUSES.include?(params[:status]) ? params[:status] : 'all'
  end
end
