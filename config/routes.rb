Rails.application.routes.draw do

  mount PgHero::Engine, at: 'pghero' if Rails.env.development? || Rails.env.staging?
  mount ActionCable.server, at: '/cable'

  devise_for :admin_users
  devise_scope :admin_user do
    get 'admin', to: 'devise/sessions#new'
  end

  devise_for :users, controllers: { invitations: 'users/invitations', registrations: 'users/registrations',
      confirmations: 'users/confirmations', sessions: 'users/sessions', passwords: "users/passwords" }

  get '/auth/facebook/callback' => 'users/omniauth_callbacks#social_sign_in'
  get '/auth/google_oauth2/callback' => 'users/omniauth_callbacks#social_sign_in'
  get '/auth/twitter/callback' => 'users/omniauth_callbacks#social_sign_in'

  get '/privacy_policy', to: 'pages#privacy_policy'
  get '/rules', to: 'pages#rules'
  get '/terms', to: 'pages#terms'
  get '/tnc', to: 'pages#tnc'
  get '/privacy', to: 'pages#privacy'
  get '/responsible', to: 'pages#responsible'
  get '/help', to: 'pages#help'
  get 'health_check', to: 'health_checks#health'

  root to: 'admin/dashboard#index'

  get '/accounts/:player_id/session', to: 'api/qtech_casino_games#verify_session'
  get '/accounts/:player_id/balance', to: 'api/qtech_casino_games#balance'

  # root to: 'dashboard#home'

  # resources :dashboard, only: %I[index] do
  #   collection do
  #     get :countries_list
  #     get :tournament_fixtures
  #     get :get_match_markets
  #     get :search
  #     get :highlight_and_last_minutes_matches
  #   end
  # end

  # get :sport_bettings , to: 'dashboard#index'

  require 'sidekiq/web'
  use_doorkeeper # https://github.com/doorkeeper-gem/doorkeeper#routes

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['sidekiq_username'])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['sidekiq_password']))
  end if Rails.env.production? || Rails.env.staging?
  mount Sidekiq::Web, at: '/sidekiq'

  post 'api/v1/auth/facebook_access_token/callback', to: 'api/users#social_sign_in'
  post 'api/v1/auth/google_oauth2_access_token/callback', to: 'api/users#social_sign_in'
  post 'api/v1/auth/twitter_access_token/callback', to: 'api/users#social_sign_in'

  resources :content_images, only: %I[create destroy]
  # concern :favouriteable do
  #   resources :favourites, only: %I[create destroy]
  # end

  # resources :fund_transfers, only: :index

  # resources :sports, concerns: :favouriteable, only: %I[index show] do
  #   resources :matches, only: [:show]
  #   member do
  #     #get :matches
  #     #get :tournaments
  #     get :live_scores
  #   end
  # end

  # resources :leaderboards do
  #   collection do
  #     get :world
  #     get :match
  #   end
  # end

  # resources :topics, only: %I[index]

  # resources :matches, only: %I[index] do
  #   member do
  #     get :live_score
  #     get :odds_summary
  #   end
  #   collection do
  #     get :available_matches
  #   end
  #   resources :markets do
  #     collection do
  #       get :filters
  #       get :odds_data
  #     end
  #   end
  #   resources :teams, concerns: :favouriteable, only: :index
  # end
  # resources :markets, only: %I[index]

  # resources :teams, concerns: :favouriteable, only: :index

  # resources :tournaments, concerns: :favouriteable, only: %I[index show] do
  #   member do
  #     get :matches
  #     get :teams
  #     get 'matches/my_bets', to: 'matches#my_bets'
  #   end

  #   collection do
  #     get :my_bets
  #   end
  # end

  # resources :languages, only: :index

  # resources :dialects, only: :index

  # resources :seasons, only: :index

  # resources :live_bettings, only: :index do
  #   collection do
  #     get :events_list
  #     post :add_favorite
  #     delete :remove_favorite
  #   end
  # end

  # namespace :users do
  #   controller :sessions do
  #     delete :sign_out, action: :destroy
  #     post :sign_in, action: :create
  #   end

  #   controller :registrations do
  #     post :users, action: :create, path: ''
  #     patch :users, action: :update, path: ''
  #   end

  #   # resources :security_questions, only: :index do
  #   #   post :verify
  #   # end

  #   resources :betting_pools, only: %I[index]

  #   resource :passwords, only: %I[new create update]
  #   resource :preferences, only: %I[show update]
  # end

  # # resources :security_questions, only: :index
  # resources :preferences, only: :index
  # resources :wallets, only: :index
  # resources :ledgers, only: :index

  namespace :webhooks do
    namespace :fastpay do
      match :payments, to: 'payments#create', via: :post
    end
    namespace :lsports do
      match 'inplay/settlement', to: 'inplay#settlement', via: :post
    end
  end

  # resources :accumulator_bets, only: %I[index create] do
  #   collection do
  #     post :batch_delete
  #     delete :delete_bets
  #     post :confirm
  #     post :cashout
  #   end
  # end

  # resources :countries, only: %I[index] do
  #   member do
  #     get :cities
  #   end
  # end

  # resources :occupations, only: %I[index]

  # resources :organizations, only: %I[index]

  # resources :scores, only: :index

  # resources :bets, only: %I[create index] do
  #   collection do
  #     post :hold
  #     post :confirm
  #     get :my_bets
  #     get :add_bet_slip
  #     get :remove_bet_slip
  #   end
  # end

  # resources :cashout, only: %I[create] do
  #   collection do
  #     post :status
  #   end
  # end
  # resources :hold, only: %I[create] do
  #   collection do
  #     post :confirm
  #     post :batch_delete
  #     get :current_odds
  #   end
  # end

  # resources :friends, only: %I[index destroy]
  # resources :friend_requests, only: :create do
  #   collection do
  #     post :accept
  #     delete :decline
  #   end
  # end

  # resources :groups, only: %I[index]

  # get 'tournaments/:tournament_id/matches/:match_id/my_bets', to: 'bets#my_bets'

  namespace :api, defaults: { formate: 'json' } do
    scope '(v:version)', format: false, defaults: { format: :json, version: 1 }, constraints: { version: /[1]/ } do
      concern :favouriteable do
        resources :favourites, only: %I[create destroy] do
          get 'favourites', on: :collection, controller: "favourites", action: "index"
        end
      end

      namespace :test, defaults: { formate: 'json' } do
        resources :bet do
          collection do
            get :resolve_bet
            get :resettel_bet
            get :run_schedule_matches_job
            get :run_odds_change_job
            get :check_amqp_listener_status
            get :set_amqp_listener_status
            get :get_match_firestore_data
          end
        end
      end

      resources :sports, concerns: :favouriteable, only: %I[index show] do
        member do
          get :matches
          get :tournaments
          get :live_scores
        end
      end

      resources :leaderboards do
        collection do
          get :world
          get :match
        end
      end

      resources :betting_pools, only: %I[index show] do
        resources :participants, only: %I[create index]
        resources :bets, only: %I[create]
        resources :hold, only: %I[create]
        resources :accumulator_bets, only: %I[create]
        member do
          get :matches
          get :wallet
        end
      end

      resources :topics, only: %I[index]

      resources :search, only: %I[index]

      resources :popups, only: %I[index]

      resources :matches, only: %I[index show] do
        member do
          get :live_score
          get :odds_summary
          post :add_favourite
          delete :remove_favourite
        end
        collection do
          get :favourite_matches
          get :available_matches
          get :odds_change
          get :live_matches
          get :favorites
        end
        resources :markets do
          collection do
            get :filters
            get :odds_data
          end
        end
        resources :teams, concerns: :favouriteable, only: :index
      end
      resources :markets, only: %I[index]
      resources :categories, only: %I[index]

      resources :teams, concerns: :favouriteable, only: :index do
        member do
          get :matches
        end
      end

      resources :tournaments, concerns: :favouriteable, only: %I[index show] do
        member do
          get :matches
          get :teams
          get 'matches/my_bets', to: 'matches#my_bets'
        end

        collection do
          get :my_bets
          get :uid
        end
      end

      resources :languages, only: :index

      resources :pages do
        collection do
          get 'privacy_policy'
          get 'rules'
          get 'terms'
          get 'responsible_gambling'
          get 'faqs'
          get 'sports_betting'
        end
      end

      resources :dialects, only: :index

      resources :seasons, only: :index

      namespace :users do
        controller :sessions do
          delete :sign_out, action: :destroy
          post :sign_in, action: :create
        end

        controller :registrations do
          post :users, action: :create, path: ''
          patch :users, action: :update, path: ''
          get :check_phone_availability, action: :check_phone_availability, path: 'check_phone_availability'
          post :metamask_user, action: :metamask_user, path: 'metamask_user'
          get :metamask_address_exist, action: :metamask_address_exist, path: 'metamask_address_exist'

        end

        controller :confirmations do
          get :confirmation, action: :show, path: 'confirmation'
          post :confirmation, action: :create, path: 'confirmation'
        end

        # resources :security_questions, only: :index do
        #   post :verify
        #end

        resources :betting_pools, only: %I[index]

        resource :passwords, only: %I[create update] do
          collection do
            post :mobile_token
            post :send_forget_password_otp
            post :confirm_forget_password
          end
        end

        resource :preferences, only: %I[show update] do
          collection do
            post :upload_kyc
            post :upload_profile_pic
            get :favourites
            get :common_settings
          end
        end

        resource :onboarding_steps, only: :update do
          collection do
            post :verify_phone
          end
        end

        resource :limits, only: %I[show update]
        resources :referrals, only: :index

        controller :promo_codes do
          get :verify, action: :verify, path: 'verify_promo_code'
        end

        resources :device_ids, only: :create
      end

      #resources :security_questions, only: :index
      resources :preferences, only: :index
      resources :wallets, only: :index
      resources :ledgers, only: :index
      resources :deposits, only: :create do
        collection do
          get :available_methods
          post :metamask_deposit
          post :generate_deposit_address
          post :transaction
        end
      end
      resources :payouts, only: :create do
        collection do
          get :available_methods
        end
      end

      resources :settings, only: :index do
        collection do
          get :languages
        end
      end

      resources :accumulator_bets, only: %I[index create] do
        collection do
          post :batch_delete
          delete :delete_bets
          post :confirm
          post :cashout
        end
      end

      resources :countries, only: %I[index] do
        member do
          get :cities
        end
        collection do
          get :registration_countries
        end
      end

      resources :occupations, only: %I[index]

      resources :organizations, only: %I[index]

      resources :scores, only: :index

      resources :bets, only: %I[create index] do
        collection do
          post :hold
          post :confirm
        end
      end

      resources :cashout, only: %I[create] do
        collection do
          post :status
        end
      end
      resources :hold, only: %I[create] do
        collection do
          post :confirm
          post :batch_delete
          get :current_odds
        end
      end

      resources :friends, only: %I[index destroy]
      resources :friend_requests, only: :create do
        collection do
          post :accept
          delete :decline
        end
      end

      resources :casino, only: :index do
        collection do
          get :categories
          get :featured
          get :init_game_session
        end
        member do
          get :lobby
        end
      end

      resources :qtech_casino_games, only: :index do
        collection do
          get :categories
          get :featured
          get :init_game_session
        end
        member do
          get :lobby
        end
      end

      resources :slot_games, only: :index do
        collection do
          get :featured
          get :init_game_session
        end
      end

      resources :groups, only: %I[index]

      resources :fund_transfers, only: :create do
        collection do
          get :get_user_details
        end
      end

      resources :users, only: :index do
        collection do
          get :get_email_otp
          get :username_exist
          get :deposit_allowed
          post :update_deposit_address
          post :update_user_status
          post :update_kyc_status
          post :update_withdraw_request
          post :confirm_email
        end
      end
      resources :transaction_history, only: :index
      resources :advertisements, only: :index do 
        collection do
          post :ad_visits
        end
      end

      resources :user_transactions, only: [:create, :index]

      patch 'users/delete' => 'users#delete'

      # controller :users do
      #   delete :destroy, action: :destroy
      # end

      get 'tournaments/:tournament_id/matches/:match_id/my_bets', to: 'bets#my_bets'

      # Generates API definition in Swagger JSON format.
      get 'swagger.json' => (lambda do |env|
        request = ActionDispatch::Request.new(env)
        yaml    = Pathname.new "#{Rails.application.paths['config'].existent.first}/api.yml"
        swagger = YAML.safe_load(ERB.new(yaml.read).result) || {}
        version = env['action_dispatch.request.path_parameters'].try(:fetch, :version)
        swagger = swagger[version] || swagger
        swagger['host'] &&= request.host_with_port
        swagger['basePath'] &&= request.fullpath.gsub(%r{/swagger\.json}, '')
        swagger['schemes'].try(:replace, Array.wrap(request.scheme))
        [
          Rack::Utils.status_code(:ok),
          { 'Content-Type' => 'application/json' },
          Array.wrap(JSON.pretty_generate(swagger))
        ]
      end)

      get 'goalserve/schedule_match/sport', to: 'goal_serve/schedule_match#sport'
      get 'goalserve/schedule_match/result/:match_schedule_date/:match_uid', to: 'goal_serve/schedule_match#result'

      get 'lsports/schedule_match/get_fixtures', to: 'lsports/schedule_match#get_fixtures'
      get 'lsports/schedule_match/get_fixture_markets', to: 'lsports/schedule_match#get_fixture_markets'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    resources :admin_users do
      collection do
        get :search
        patch :update_commision_settings
      end
      member do
        patch :enable_disable_user
      end

      resources :users, only: :index
      resources :ledgers, only: :index do
        collection do
          get :report
          get :search
          get :search_report
          get :search_admin
          get :search_affiliate
          get :affiliate_ledgers
        end
      end
      resources :wallets, only: %I[edit update]
      resources :pool_wallets do
        collection do
          post :transfer
          post :withdraw_all
          post :normal_user_withdraw
        end
      end
    end

    resources :transfer_funds, only: %I[index] do
      collection do
        post :manaul_transfer
        post :retry_request
      end
    end

    resources :cms_templates do
      member do
        post :send_now
      end
      collection do
        post :promotion_notification
      end
    end

    resources :gammabet_setting, only: %I[edit update] do
      collection do
        post :navbar_type
        patch :update_referral_settings
        patch :update_notification_settings
        patch :update_commision_settings
      end
    end

    resources :dashboard, only: :index do
      collection do
        get :user_chart
        get :favourite_matches
        get :favourite_markets
        get :reset_counter
        get :summaries_filter
        get :sports_overview_filter
        get :esports_overview_filter
        get :casino_overview_filter
        get :slot_game_overview_filter
        get :top_sports_filter
        get :profit_filter
        get :top_casino_filter
        get :top_slot_game_filter
      end
    end

    resources :q_tech_free_rounds, only: [:index, :new, :create, :destroy]

    resources :dashboard, only: :index
    resources :sports, only: %I[index update show] do
      resources :tournaments
      resources :markets, only: %I[index edit update show]
      collection do
        get :search
        patch :update_sports_rank
        get :get_tournaments
      end
    end
    resources :teams, only: :index
    resources :matches, only: %I[index update show] do
      member do
        patch :change_market_status
        patch :update_match_details
      end
      collection do
        get :search
        get :get_markets
        get :fetch_tournaments
      end
      resources :markets, only: %I[index edit update show]
      resources :bets, only: :index
    end
    resources :tournaments, except: %I[create] do
      collection do
        get :get_matches
      end
      member do
        patch :change_status
      end
      collection do
        patch :update_tournaments_rank
        get :search
      end
      resources :matches, only: %I[index] do
        collection do
          get :search
        end
      end
    end
    resources :users do
      member do
        delete :stats
        patch :enable_disable_user
        patch :update_kyc_status
        patch :update_sport_visibility
        patch :update_settings
        get :get_player_kpis
      end
      collection do
        get :search
      end
      resources :bets, only: :index do
        collection do
          get :search
        end
      end
      resources :combo_bets, only: :index do
        collection do
          get :search
        end
      end
      resources :ledgers, only: :index do
        member do
          patch :approve_refund
        end
        collection do
          get :report
          get :search
        end
      end
      resources :wallets, only: %I[edit update] do
        member do
          patch :update_currency
        end
      end
    end

    resources :bets, only: :index do
      collection do
        get :search
        delete :suspend_bet
      end
    end

    resources :combo_bets, only: :index do
      collection do
        get :search
      end
    end

    resources :markets do
      collection do
        get :get_sports
        get :get_sports_markets
        patch :update_markets_rank
        patch :update_sport_market
      end
    end
    resources :histories, only: [] do
      collection do
        get :bets
      end
    end
    resources :bet_types
    resources :play_types
    #resources :security_questions, only: %I[index create update destroy]

    resources :groups

    resources :promo_codes do
      collection do
        get :set_users
        get :list_promo_usage
        post :send_promo
      end
    end

    resources :popups

    resources :disputes, only: :index

    resources :advertisements
    resources :countries, only: :index do
      collection do
        patch :update_countries_rank
      end
      member do
        patch :change_status
      end
    end

    resources :transfer_records, only: :index do
      collection do
        get :user_records
      end
    end

    resources :withdrawals do
      member do
        post :confirm
        post :reject
      end
    end

    resources :deposits do
      member do
        post :confirm
        post :reject
      end
    end

    resources :casino do
      collection do
        patch :update_menu_for_casino_item
        patch :update_casino_item
      end
    end

    resources :slot_games

    resources :casino_menus, only: [:index, :create, :new, :update, :edit] do
      member do
        patch :toggle_featured_status
      end
      collection do
        patch :change_menus_order
      end
    end

    resources :reports do
      collection do
        get :bets
        get :combo_bets
        get :sports
        get :payments
        get :payments_by_region
        get :deposits
        get :casino
        get :casino_report_by_games
        get :slot_game
        get :slot_game_report_by_games
      end
    end

    resources :languages, only: :index do
      member do
        patch :toggle_enabled
      end
    end

    resources :device_ids, only: :create
  end

  # resources :users, only: %I[edit update] do
  #   member do
  #     post :set_rc_timestamp
  #     get :responsive_gambling
  #     post :update_responsive_gambling
  #   end
  # end

  # match 'listen/inplay_soccer', via: [:get, :post]

  resources :casino, only: :index do
    member do
      get :init_game_session
      get :lobby
    end
    collection do
      post :sid
      post :check
      post :debit
      post :balance
      post :credit
      post :cancel
      match :callback, via: [:get, :post]
    end
  end

  # Slot Games
  resources :slot_games, only: :index do
    collection do
      post :authenticate
      post :getStake
      post :returnWin
      post :rollbackStake
      post :getFunds
      post :gameClose
    end
  end


  # get 'get_user_details', to: 'fund_transfers#get_user_details'
  # get 'transaction_history', to: 'fund_transfers#transaction_history'
  # post 'initiate_transfer', to: 'fund_transfers#initiate_transfer'
end
