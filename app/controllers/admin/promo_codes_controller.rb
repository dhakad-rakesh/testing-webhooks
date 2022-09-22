class Admin::PromoCodesController < Admin::BaseController
  before_action :set_promo, only: %I[update edit show send_promo list_promo_usage]
  before_action :set_users, only: :show
  
  def index
    @promo_codes = PromoCode.order_by_recent
    filter_promo_codes if query.present?
    @promo_codes = @promo_codes.paginate(page: params[:page], per_page: Constants::PER_PAGE)
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show; end

  def filter_promo_codes
    @promo_codes = @promo_codes.where(id: query[:promo_id]) if query[:promo_id].present?
    @promo_codes = @promo_codes.where('name ILIKE ?', "%#{query[:name].strip}%") if query[:name].present?
    @promo_codes = @promo_codes.between(query[:start_date], query[:end_date]) if query[:filter_date].present?
    @promo_codes = @promo_codes.where('code ILIKE ?', "%#{query[:promo_code].strip}%") if query[:promo_code].present?
    @promo_codes = @promo_codes.send(query[:promo_status]) if query[:promo_status].present?
    @promo_codes = @promo_codes.send(query[:promo_kind]) if query[:promo_kind].present?
    @promo_codes = @promo_codes.expiring_between(query[:start_valid_date], query[:end_valid_date]) if query[:valid_till_date].present?
  end

  def new
    @promo_code = PromoCode.new
  end

  def edit; end

  def create
    @promo_code = PromoCode.new(promo_code_params.merge(currency_params))
    if @promo_code.save
      flash[:notice] = t('success_create', name: t('promo_code'))
      redirect_to admin_promo_codes_path
    else
      flash[:error] = @promo_code.errors.full_messages.join("<br/>")
      render :new
    end
  end

  def update
    @promo_code.assign_attributes(promo_code_params.merge(currency_params))

    if @promo_code.save
      flash[:notice] = t('success_update', name: t('promo_code'))
      redirect_to admin_promo_codes_path
    else
      flash[:error] = @promo_code.errors.full_messages.join("<br/>")
      render :new
    end
  end

  def set_users
    @users = User.all.paginate(per_page: Constants::PER_PAGE, page: params[:page])
    respond_to do |f|
      f.html
      f.json { render json: @users }
    end
  end

  def send_promo
    if params[:selection].eql?('selected')
      SendPromoCodeIntr.run!(promo_code: @promo_code, user_ids: params[:user_ids])
    elsif params[:selection].eql?('all')
      SendPromoCodeIntr.run!(promo_code: @promo_code, broadcast: true)
    end
    render js: "toastr.success('Request initiated')"
  rescue StandardError => e
    render js: "toastr.error(#{e.message})"
  end

  def list_promo_usage
    @records = @promo_code.user_promo_codes
                          .succeeded
                          .joins(:ledger, :user)
                          .select('ledgers.created_at, users.user_number, users.first_name, users.last_name, users.id, user_promo_codes.cashback_value')
                          .order('ledgers.created_at DESC')
                          .paginate(per_page: Constants::PER_PAGE, page: params[:page])
  end

  private

  def currency_params
    currency_params = {}
    param = params.require(:promo_code).permit(:threshold_amount, :maximum_cashback)

    %i[threshold_amount maximum_cashback].each do |sym|
      if param[sym].present?
        currency_params[sym] = { 'IQD' => param[sym].to_f }
      end
    end
    currency_params
  end

  def promo_code_params
    params.require(:promo_code).permit(:name, :code, :percent, :kind,
      :status, :valid_from, :valid_till, :limit_per_user, :usage_limit,
      :promo_type)
  end

  def set_promo
    @promo_code = PromoCode.find_by(id: params[:id])
    return if @promo_code.present?
    flash.now[:error] = "Promo code record unavailable"

    render :index
  end

  def query
    @query ||= params[:query]
  end
end