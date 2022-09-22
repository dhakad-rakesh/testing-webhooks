require 'omniauth/strategies/facebook_access_token'
require 'omniauth/strategies/google_oauth2_access_token'
require 'omniauth/strategies/twitter_access_token'

OmniAuth.config.on_failure = Api::UsersController.action(:failure)
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook_access_token, Figaro.env.facebook_key, Figaro.env.facebook_secret,
    scope: 'public_profile, email', info_fields: 'id, first_name, last_name, birthday, email',
    callback_path: '/api/v1/auth/facebook_access_token/callback'
  provider :google_oauth2_access_token, Figaro.env.google_client_id, Figaro.env.google_client_secret,
    callback_path: '/api/v1/auth/google_oauth2_access_token/callback'
  provider :twitter_access_token, Figaro.env.twitter_key, Figaro.env.twitter_secret,
    scope: 'public_profile', info_fields: 'id, first_name, last_name, birthday, email',
    callback_path: '/api/v1/auth/twitter_access_token/callback'
  provider :facebook, Figaro.env.facebook_key, Figaro.env.facebook_secret,
    scope: 'public_profile, email', info_fields: 'id, first_name, last_name, birthday, email'
  provider :google_oauth2, Figaro.env.google_client_id, Figaro.env.google_client_secret
  provider :twitter, Figaro.env.twitter_key, Figaro.env.twitter_secret
end
