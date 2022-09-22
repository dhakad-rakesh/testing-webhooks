ActionMailer::Base.smtp_settings = {
  :user_name => Figaro.env.SMTP_USERNAME,
  :password => Figaro.env.SMTP_PASSWORD,
  :domain => 'api.betdefi',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
