require_relative 'boot'

require 'rails/all'
require File.expand_path('../../lib/core_ext', __FILE__)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GammabetWeb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.eager_load_paths += %W[
      #{config.root}/lib
    ]

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    # en: English, ar: Arabic, ku: Kurdish, tr: Turkish
    config.i18n.available_locales = [:en, :ru, :cz]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.active_job.queue_adapter = :sidekiq

    #for meta info in APIs
    ActiveModelSerializers.config.adapter = :json

    config.to_prepare do
      # Configure single controller layout
      Devise::SessionsController.layout "signin"
      Devise::PasswordsController.layout "signin"
      Devise::InvitationsController.layout "signin"
      Devise::Mailer.layout "mailer"
    end

    # Enable CORS support for API endpoints.
    config.middleware.unshift ::Rack::Cors do
      allow { origins '*'; resource '/api/*', headers: :any, methods: :any, credentials: false }
    end
    # Include css files here
    config.assets.precompile += [ 'admin_application.css', "bwinner.css" ]
    config.assets.precompile += [ 'admin_application.js', 'admin/sports.js', 'admin/matches.js', 'admin/tournaments.js', 'admin/markets.js', 'admin/security_questions.js', 'admin/dashboard.js', 'admin/slot_games.js' ]
    config.action_cable.disable_request_forgery_protection = true
    # config.mongoid.logger = Logger.new(Rails.root + 'log/mongo/mongoid.log', :warn)
    config.mongoid.logger.level = Logger::FATAL

    # config.action_cable.allowed_request_origins = ['https://www.betdefiuat.com']
    # config.action_cable.allowed_request_origins = [%r{http://*}, %r{https://*}]

  end
end
