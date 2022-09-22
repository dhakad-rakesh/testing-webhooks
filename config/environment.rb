# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
GammabetWeb::Application.default_url_options = GammabetWeb::Application.config.action_mailer.default_url_options