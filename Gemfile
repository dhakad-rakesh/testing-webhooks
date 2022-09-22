source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.3'
# ActiveInteraction manages application-specific business logic.
gem 'active_interaction', '~> 3.6'
# activerecord-import is a library for bulk inserting data using ActiveRecord.
gem 'activerecord-import'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

# CanCanCan is an authorization library for Ruby >= 2.2.0 and Ruby on Rails >= 4.2 which restricts what resources a given user is allowed to access.
gem 'cancancan'

gem "down", "~> 5.0"

# Countries is a collection of all sorts of useful information for every country in the ISO 3166 standard.
gem 'countries'

# Cities of any country
gem 'city-state'

gem 'firebase'
# gem 'rails', '~> 5.1.4'
gem 'rails', '~> 5.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Bunny is a RabbitMQ client that supports all recent RabbitMQ features.
gem 'bunny'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'redis'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# gem 'redis-namespace'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# A simple HTTP and REST client for Ruby
gem 'rest-client', '~> 2.0.1'
# Sidke for Background processing
gem 'sidekiq'
# sidekiq-scheduler is an extension to Sidekiq that pushes jobs in a scheduled way, mimicking cron utility
gem 'sidekiq-scheduler'
gem 'sidekiq-limit_fetch'
gem 'google-cloud-firestore'
gem 'discard', '~> 1.2'
gem 'http_accept_language'
gem 'fcm'
gem 'serviceworker-rails'
gem 'alertifyjs-rails'
gem 'mongoid', '~> 7.0.5'
gem 'redis-mutex'
gem 'sidekiq-failures'
gem 'mobility'

# Manage environment specific configuration
gem "figaro"

#bootstrap
gem 'bootstrap-sass'

#jquery
gem 'jquery-turbolinks'
gem 'jquery-ui-rails'
gem 'jquery-rails'

#devise
gem 'devise'
gem 'devise_invitable'
#
gem 'font-awesome-rails'

#serializers
gem "active_model_serializers"

#rack-cors
gem 'rack-cors', require: 'rack/cors'

# Dalli is a high performance pure Ruby client for accessing memcached servers.
# gem 'dalli'

#doorkeeper
gem 'doorkeeper'

#jwt
gem 'doorkeeper-jwt'
gem 'jwt'

#paginate
gem 'will_paginate'
gem 'will_paginate-bootstrap'

#ably-rest
gem 'ably-rest'

gem 'omniauth'
gem 'omniauth-facebook', '~> 4.0'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'geocoder'
gem 'rufus-scheduler', require: false
gem 'file_validators'

#deployment
gem 'mina'
gem 'mina-puma', require: false
gem "non-stupid-digest-assets"
gem 'mina-multistage', require: false
gem 'mina-sidekiq'

#monitoring
gem 'newrelic_rpm'

#Error reporting
gem 'honeybadger', '~> 4.0'

#email sending
gem 'sendgrid-ruby'

# For adding bootstrap datetimepicker
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.47'

# Image processing gem used by ActiveStorage for resizing etc.
gem 'mini_magick'

# Javascript library for Gnome / Growl type non-blocking notifications
gem 'toastr-rails'

# For active storage
gem "aws-sdk-s3", require: false

# for captcha
gem "recaptcha", require: "recaptcha/rails"

gem 'popper_js'
gem 'summernote-rails'

#Select2
gem "select2-rails"
gem 'aasm'
gem 'phonelib'
gem 'google-api-client'
gem 'httparty', '~> 0.16.2'

group :development, :test do
  gem 'rspec-rails', '~> 3.7'
  gem 'factory_bot_rails'
  gem 'pry-rails'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem "letter_opener"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # utility gem for code quality and debuging
  gem 'mailcatcher'
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
  gem 'brakeman',  require: false
  gem 'bundle-audit', require: false
  gem 'xray-rails'
  gem 'better_errors'
end
group :development, :staging do
  gem 'pghero'
  gem 'pg_query', '>= 0.9.0'
end

# Very simple rolifyes library without any authorization enforcement supporting scope on resource object.
gem 'rolify'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
