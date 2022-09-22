Recaptcha.configure do |config|
  config.site_key = Figaro.env.RECAPTCHA_SITE_KEY
  config.secret_key = Figaro.env.RECAPTCHA_SECRET_KEY
end