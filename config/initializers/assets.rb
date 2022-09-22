# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join('/app/assets/fonts')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( koorabet_theme.js koorabet_theme.css user_application.js user_application.css main.css user_theme.js user_theme.css)
Rails.application.config.assets.precompile += %w( admin/languages.js admin/dialects.js admin/topics.js main.js admin/countries.js admin/markets/actions.js admin/list_filter.js admin/users.js admin/sports/actions.js admin/reports)
Rails.configuration.assets.precompile += %w[firebase-messaging-sw.js manifest.json]
