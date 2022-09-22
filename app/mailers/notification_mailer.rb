class NotificationMailer < ApplicationMailer

  def schedule_matches_job(exception, exception_backtrace)
    @exception = exception
    @exception_backtrace = exception_backtrace
    mail(to: 'ajadhav@grepruby.io', subject: 'Schedule matches job executed')
  end

  def feed_result_job(exception, match_id, exception_backtrace)
    @exception = exception
    @match_id = match_id
    @exception_backtrace = exception_backtrace
    mail(to: 'ajadhav@grepruby.io', subject: 'Feed results job executed')
  end

  def clear_logs_job
    @message = message
    mail(to: get_developer_email, subject: 'Clear logs job executed')
  end    

  def casino_error_logs_job(params, s_trnsaction, e_rst, error)
    @params = params
    @s_trnsaction = s_trnsaction
    @e_rst = e_rst
    @error = error
    mail(to: get_developer_email, subject: 'Casino Error logs')
  end

  def credit_limit_exeeded(csv)
    attachments['user_credit_limit_exeeded_report.csv'] = { mime_type: 'text/csv', content: csv }
    mail(to: support_email, subject: credit_limit_subject)
  end

  def balance_limit_exeeded(csv)
    attachments['user_balance_limit_exeeded_report.csv'] = { mime_type: 'text/csv', content: csv }
    mail(to: support_email, subject: balance_limit_subject)
  end

  def deposited_amount_alert(user, amount)
    @amount = amount
    @user = user
    mail(to: support_email, subject: deposited_amount_subject)
  end

  def affiliate_link(admin)
    @user = admin
    mail(from: Figaro.env.FROM_EMAIL_ADDRESS, to: admin.email, subject: 'Redirection link')
  end

  def kyc_request(admin, user)
    @user = user
    mail(from: Figaro.env.FROM_EMAIL_ADDRESS, to: admin.email, subject: 'KYC Request')
  end  

  def kyc_request(admin, user)
    @user = user
    mail(from: Figaro.env.FROM_EMAIL_ADDRESS, to: admin.email, subject: 'KYC Request')
  end  

  def withdraw_request(admin, user, amount)
    @amount = amount
    @user = user
    mail(from: Figaro.env.FROM_EMAIL_ADDRESS, to: admin.email, subject: 'Withdrawal Request')
  end

  def withdraw_request_status(ledger)
    @ledger = ledger
    mail(from: Figaro.env.FROM_EMAIL_ADDRESS, to: ledger.betable.email, subject: 'Withdrawal Request Status')
  end

  def withdraw_request_initiate(ledger)
    @ledger = ledger
    mail(from: Figaro.env.FROM_EMAIL_ADDRESS, to: ledger.betable.email, subject: 'Withdrawal Request Status')
  end

  def kyc_request_status(user)
    @user = user
    mail(from: Figaro.env.FROM_EMAIL_ADDRESS, to: user.email, subject: 'KYC Request Status')
  end

  def kyc_request_initiate(user)
    @user = user
    mail(from: Figaro.env.FROM_EMAIL_ADDRESS, to: user.email, subject: 'KYC Request Status')
  end

  private
  
  def get_developer_email
    Figaro.env.developers_mail
  end

  def support_email
    Figaro.env.support_email
  end

  def credit_limit_subject
    "Users with more than #{action_helper.number_to_human(Figaro.env.user_credit_limit.to_i, format: '%n%u', precision: 2, units: {thousand: 'K'})} credited in account #{Figaro.env.user_credit_limit_interval} || #{(Time.zone.now-1.day).to_s}"
  end

  def balance_limit_subject
    "Users with more than #{action_helper.number_to_human(Figaro.env.user_balance_limit.to_i, format: '%n%u', precision: 2, units: {thousand: 'K'})} balance || #{Time.zone.now.to_s}"
  end

  def deposited_amount_subject
    @user.instance_of?(User) ? deposite_amt_message('user') : deposite_amt_message('reseller')
  end

  def deposite_amt_message(type)
    "#{@amount} is credited to #{type}: #{@user.email}"
  end

  def action_helper
    view = ActionView::Base.new
    view.class_eval { include ApplicationHelper }
    view
  end
end
