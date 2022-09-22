include LedgersHelper
class Admin::LedgersController < Admin::BaseController
  before_action :set_user
  before_action :set_user_ledgers, only: [:index, :search, :search_admin]
  before_action :set_report_data, only: [:report, :search_report]
  before_action :set_ledgers, only: [:affiliate_ledgers, :search_affiliate]
  skip_load_and_authorize_resource only: [:report, :search, :search_report, :search_admin]

  def index
    @ledgers = @ledgers.paginate(page: params[:page], per_page: Constants::PER_PAGE) unless params[:format].eql?('csv')
    respond_to do |format|
      format.csv { send_data @ledgers.to_csv, filename: "user_transactions_#{@user.id}_#{Time.zone.now}.csv" }
      format.html
      format.js
    end
  end

  def search
    @ledgers = @ledgers.where(id: params[:transaction_id]) if params[:transaction_id].present?
    @ledgers = @ledgers.between(params[:created_at_start_date].to_date, params[:created_at_end_date].to_date) if params[:created_at].present?
    @ledgers = @ledgers.send(params[:transaction_type]) if params[:transaction_type].present?
    @ledgers = @ledgers.search_by_amount(params[:min_amt].to_f, params[:max_amt].to_f) if params[:min_amt].present? && params[:max_amt].present?
    @ledgers = @ledgers.send(params[:status]) if params[:status].present?
    @ledgers = @ledgers.send(params[:payment_system]) if params[:payment_system].present?
    @ledgers = @ledgers.paginate(page: params[:page], per_page: Constants::PER_PAGE) || [] unless params[:format].eql?('csv')
    respond_to do |format|
      format.csv { send_data @ledgers.to_csv, filename: "user_transactions_#{@user.id}_#{Time.zone.now}.csv" }
      format.html
      format.js
    end
  end

  def search_admin
    search_ledgers
  end

  def search_affiliate
    search_ledgers
  end

  def search_ledgers
    @ledgers = @ledgers.between(params[:start_date].to_date.beginning_of_day, params[:end_date].to_date.end_of_day) if params[:start_date].present? && params[:end_date].present?
    if params[:query].present?
      @ledgers = params[:query].eql?('all') ? @ledgers : @ledgers.search(params[:query])
    end
    @ledgers = @ledgers.search_by_amount(params[:min_amt].to_f, params[:max_amt].to_f) if params[:min_amt].present? && params[:max_amt].present?
    @ledgers = @ledgers.paginate(page: params[:page]) || []
    return render :index if params[:page].present?
    respond_to do |format|
      format.js
    end
  end

  def report; end

  def affiliate_ledgers
    @ledgers = @ledgers.paginate(page: params[:page], per_page: Constants::PER_PAGE) unless params[:format].eql?('csv')
     respond_to do |format|
       format.csv { send_data @ledgers.to_csv, filename: "user_transactions_#{@user.id}_#{Time.zone.now}.csv" }
       format.html
       format.js
     end
  end

  def search_report
    return render :report if params[:page].present?
    respond_to do |format|
      format.js
    end
  end

  def approve_refund
    refund_ledger = @user.ledgers.unapproved.where(id: params[:id]).first
    if refund_ledger.present? && refund_ledger.update_attribute(:approved, true)
      #credit the amount to users wallet
      refund_ledger.wallet.credit(refund_ledger.amount.to_f)
      flash[:success] = t('success_update', name: t('record'))
    else
      flash[:error] = t('not_found', name: t('record'))
    end
    redirect_to admin_user_ledgers_path(@user, page: params[:page])
  end

  private

  def set_user
    @user = if params[:user_id]
              User.find_by(id: params[:user_id])
            elsif params[:reseller_user_id]
              AdminUser.find_by(id: params[:reseller_user_id])
            elsif params[:admin_user_id]
              AdminUser.find_by(id: params[:admin_user_id])
            end
    if @user.present?
      return if current_admin_user.is_super_admin?
      return if @user.id.eql?(current_admin_user.id)
    end
    flash[:error] = t('not_found', name: t('user'))
    redirect_back(fallback_location: admin_users_path)
  end

  def set_user_ledgers
    @ledgers = @user.ledgers.order_by_recent
  end

  def set_report_data
    @start_date = params[:start_date].to_date.beginning_of_day rescue DateTime.now.beginning_of_week
    @end_date = params[:end_date].to_date.end_of_day rescue DateTime.now.end_of_week
    params[:wallet_type] == 'self' ? self_wallet_report : admin_wallet_report
  end

  def self_wallet_report
    @ledgers = @user.reseller_wallet.ledgers.order_by_recent.between(@start_date, @end_date)
    @ledgers = filter_ledgers(@ledgers) if filter_ledgers(@ledgers).present?
    @credited_amount = @ledgers.credit.sum(:amount)
    @debited_amount = @ledgers.debit.sum(:amount).abs
    @ledgers = @ledgers.paginate(page: params[:page], per_page: 10)
  end

  def admin_wallet_report
    #point wallet is the admin wallet
    @ledgers = @user.current_wallet.ledgers.order_by_recent.between(@start_date, @end_date)
    @ledgers = filter_ledgers(@ledgers) if filter_ledgers(@ledgers).present?
    @credited_amount = @ledgers.credit.sum(:amount).to_f
    # @debited_amount = @ledgers.debit.sum(:amount).abs
    # @reseller_stats = @user.reseller_stats(@start_date, @end_date)
    @user_wegered_amount = @user.affiliate_stats[:wagered_amount]
    @due_wegered_amount = @user_wegered_amount - @user.current_wallet.wagered_amount
    @payout_percentage = reseller_percentage_calc(@due_wegered_amount, @user)
    @due_amount = @due_wegered_amount * @payout_percentage / 100
    @ledgers = @ledgers.paginate(page: params[:page], per_page: 10)
  end

  def filter_ledgers(ledgers)
    if params[:query].present?
      @ledgers = params[:query].eql?('all') ? ledgers : ledgers.search(params[:query])
    end
    @ledgers = ledgers.search_by_amount(params[:min_amt].to_f, params[:max_amt].to_f) if params[:min_amt].present? && params[:max_amt].present?
  end

  def set_ledgers
    affilite_ids = AdminUser.with_role(:sub_admin).ids
    @ledgers = Ledger.affiliate_ledgers(affilite_ids).order_by_recent
  end
end
