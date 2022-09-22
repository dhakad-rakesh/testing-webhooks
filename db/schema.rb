# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_19_182630) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "accumulator_bets", force: :cascade do |t|
    t.float "odds"
    t.float "stake", default: 0.0
    t.integer "status", default: 0
    t.bigint "user_id"
    t.bigint "wallet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "play_number"
    t.float "cashed_out_amount"
    t.bigint "betting_pool_id"
    t.index ["betting_pool_id"], name: "index_accumulator_bets_on_betting_pool_id"
    t.index ["user_id"], name: "index_accumulator_bets_on_user_id"
    t.index ["wallet_id"], name: "index_accumulator_bets_on_wallet_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "street_address"
    t.string "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true
    t.boolean "enable", default: true
    t.float "reseller_percentage", default: 80.0
    t.integer "admin_user_id"
    t.integer "sub_admin_user_id"
    t.integer "label", default: 0
    t.datetime "discarded_at"
    t.string "code"
    t.text "settings"
    t.string "reciever_address"
    t.index ["code"], name: "index_admin_users_on_code", unique: true
    t.index ["discarded_at"], name: "index_admin_users_on_discarded_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "admin_users_roles", id: false, force: :cascade do |t|
    t.bigint "admin_user_id"
    t.bigint "role_id"
    t.index ["admin_user_id", "role_id"], name: "index_admin_users_roles_on_admin_user_id_and_role_id"
    t.index ["admin_user_id"], name: "index_admin_users_roles_on_admin_user_id"
    t.index ["role_id"], name: "index_admin_users_roles_on_role_id"
  end

  create_table "advertisements", force: :cascade do |t|
    t.string "name"
    t.boolean "enabled", default: true
    t.text "ad_url"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "click_count", default: 0
    t.float "per_click_cost", default: 0.0
  end

  create_table "amqp_audit_logs", force: :cascade do |t|
    t.string "routing_key"
    t.string "timestamp_in_ms"
    t.text "xml_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "event_id"
    t.string "log_type"
    t.string "routing_type"
    t.index ["routing_type"], name: "index_amqp_audit_logs_on_routing_type"
  end

  create_table "bet_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "market_type", default: 0
  end

  create_table "bet_types_play_types", id: false, force: :cascade do |t|
    t.bigint "bet_type_id", null: false
    t.bigint "play_type_id", null: false
    t.index ["bet_type_id", "play_type_id"], name: "index_bet_types_play_types_on_bet_type_id_and_play_type_id"
    t.index ["play_type_id", "bet_type_id"], name: "index_bet_types_play_types_on_play_type_id_and_bet_type_id"
  end

  create_table "bets", force: :cascade do |t|
    t.bigint "user_id"
    t.float "stake"
    t.string "odds"
    t.json "information", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "rake", default: 0.0
    t.integer "bet_type", default: 0
    t.bigint "market_id"
    t.bigint "outcome_id"
    t.bigint "match_id"
    t.json "specifier_text"
    t.integer "status", default: 0
    t.integer "tournament_id"
    t.bigint "wallet_id"
    t.string "team_name"
    t.string "player_name"
    t.string "period"
    t.string "play_number"
    t.string "country"
    t.string "continent"
    t.integer "accumulator_bet_id"
    t.float "cashed_out_amount"
    t.bigint "betting_pool_id"
    t.integer "combo_bet_id"
    t.float "total", default: 0.0
    t.integer "play_type"
    t.decimal "winnings", precision: 17, scale: 5, default: "0.0"
    t.decimal "profit", precision: 17, scale: 5, default: "0.0"
    t.decimal "bonus_stake", precision: 17, scale: 5, default: "0.0"
    t.index ["accumulator_bet_id"], name: "index_bets_on_accumulator_bet_id"
    t.index ["bet_type"], name: "index_bets_on_bet_type"
    t.index ["betting_pool_id"], name: "index_bets_on_betting_pool_id"
    t.index ["market_id"], name: "index_bets_on_market_id"
    t.index ["match_id", "market_id", "status"], name: "index_bets_on_match_id_and_market_id_and_status"
    t.index ["match_id"], name: "index_bets_on_match_id"
    t.index ["outcome_id"], name: "index_bets_on_outcome_id"
    t.index ["status"], name: "index_bets_on_status"
    t.index ["tournament_id"], name: "index_bets_on_tournament_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
    t.index ["wallet_id"], name: "index_bets_on_wallet_id"
  end

  create_table "betting_pools", force: :cascade do |t|
    t.integer "status", default: 0
    t.integer "entry_amount"
    t.integer "points_per_user"
    t.integer "total_participants", default: 0
    t.integer "winnings_distribution_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "last_match_id"
    t.integer "minimum_participants"
  end

  create_table "betting_pools_matches", id: false, force: :cascade do |t|
    t.bigint "betting_pool_id"
    t.bigint "match_id"
    t.index ["betting_pool_id", "match_id"], name: "index_betting_pools_matches_on_betting_pool_id_and_match_id", unique: true
    t.index ["betting_pool_id"], name: "index_betting_pools_matches_on_betting_pool_id"
    t.index ["match_id"], name: "index_betting_pools_matches_on_match_id"
  end

  create_table "casino_items", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name"
    t.string "image"
    t.string "item_type"
    t.string "provider"
    t.string "technology"
    t.boolean "has_lobby"
    t.boolean "is_mobile"
    t.boolean "has_freespins"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "casino_menu_id"
    t.index ["casino_menu_id", "active", "has_freespins"], name: "index_casino_items_menus_free_spin"
    t.index ["casino_menu_id", "active", "has_lobby"], name: "index_casino_items_menus_lobby"
    t.index ["casino_menu_id", "active", "is_mobile"], name: "index_casino_items_menus_mobile"
    t.index ["casino_menu_id", "active", "name"], name: "index_casino_items_menus_name"
    t.index ["casino_menu_id", "active", "provider", "name"], name: "index_casino_items_menus_provider_name"
    t.index ["casino_menu_id", "active", "provider"], name: "index_casino_items_menus_provider"
    t.index ["casino_menu_id", "active"], name: "index_casino_items_menus_active"
    t.index ["casino_menu_id"], name: "index_casino_items_on_casino_menu_id"
  end

  create_table "casino_menus", force: :cascade do |t|
    t.string "name"
    t.integer "menu_type", default: 0
    t.integer "menu_order"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_featured", default: false
    t.index ["menu_order", "enabled"], name: "index_casino_menus_enabled"
    t.index ["menu_order"], name: "index_casino_menus_on_menu_order"
    t.index ["menu_type"], name: "index_casino_menus_on_menu_type"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_joins", force: :cascade do |t|
    t.bigint "category_id"
    t.string "categorizable_type"
    t.bigint "categorizable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categorizable_type", "categorizable_id"], name: "index_category_joins_on_categorizable_type_and_categorizable_id"
    t.index ["category_id"], name: "index_category_joins_on_category_id"
  end

  create_table "cms_templates", force: :cascade do |t|
    t.text "content"
    t.string "subject"
    t.integer "template_for", default: 0
    t.datetime "schedule_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["template_for", "schedule_at"], name: "index_cms_templates_on_template_for_and_schedule_at"
  end

  create_table "combo_bets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "odds"
    t.float "stake"
    t.float "cashout_amount"
    t.decimal "bonus_stake", precision: 17, scale: 5, default: "0.0"
  end

  create_table "competitors", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qualifier"
    t.index ["match_id"], name: "index_competitors_on_match_id"
    t.index ["team_id", "match_id"], name: "index_competitors_on_team_id_and_match_id", unique: true
    t.index ["team_id"], name: "index_competitors_on_team_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled", default: true
    t.integer "rank"
    t.index ["uid"], name: "index_countries_on_uid", unique: true
  end

  create_table "cricket_match_scores", force: :cascade do |t|
    t.string "status"
    t.string "home_score"
    t.string "reporting"
    t.string "match_status"
    t.string "away_score"
    t.string "delivery"
    t.string "innings"
    t.string "over"
    t.string "home_penalty_runs"
    t.string "away_penalty_runs"
    t.string "home_dismissals"
    t.string "away_dismissals"
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_cricket_match_scores_on_match_id"
  end

  create_table "dialects", force: :cascade do |t|
    t.string "name"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favourites", force: :cascade do |t|
    t.string "favouriteable_type"
    t.bigint "favouriteable_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_default", default: false
    t.index ["favouriteable_type", "favouriteable_id"], name: "index_favourites_on_favouriteable_type_and_favouriteable_id"
    t.index ["user_id"], name: "index_favourites_on_user_id"
  end

  create_table "friend_requests", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "friend_id"], name: "index_friend_requests_on_user_id_and_friend_id", unique: true
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
  end

  create_table "game_sessions", force: :cascade do |t|
    t.string "game_uuid", null: false
    t.integer "player_id", null: false
    t.string "currency", default: "USD"
    t.string "session_id", null: false
    t.string "return_url"
    t.string "game_type", default: "casino"
    t.decimal "wallet_amount"
    t.decimal "balance"
    t.string "win"
    t.string "bet"
    t.string "refund"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "status", default: "in_progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_game_sessions_on_session_id"
  end

  create_table "gammabet_settings", force: :cascade do |t|
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "setting_of", default: 0
    t.boolean "allow_betting", default: true
    t.string "url"
    t.integer "user_wallet_limit", default: 40000
    t.integer "reseller_withdrawal_limit", default: 3000
    t.float "max_one_bet_amount"
    t.float "max_daily_bet_amount"
    t.float "max_weekly_bet_amount"
    t.float "max_monthly_bet_amount"
    t.float "max_single_amount"
    t.float "max_day_deposit_amount"
    t.float "max_weekly_deposit_amount"
    t.float "max_monthly_deposit_amount"
    t.float "balance_amount_limit"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_users", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.index ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id"
    t.index ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "image_id"
    t.string "image_filename"
    t.integer "image_size"
    t.string "image_content_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "symbol"
    t.boolean "is_default", default: false
  end

  create_table "languages_users", force: :cascade do |t|
    t.bigint "language_id"
    t.bigint "user_id"
    t.string "nature"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_languages_users_on_language_id"
    t.index ["user_id"], name: "index_languages_users_on_user_id"
  end

  create_table "ledgers", force: :cascade do |t|
    t.bigint "wallet_id"
    t.string "remark"
    t.integer "transaction_type", default: 0
    t.float "amount", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tracking_id"
    t.integer "betable_id"
    t.string "betable_type"
    t.integer "source_wallet_id"
    t.string "transaction_id"
    t.boolean "approved", default: true
    t.bigint "transfer_record_id"
    t.integer "status", default: 0
    t.integer "mode"
    t.string "account_details"
    t.integer "kind", default: 0
    t.bigint "user_promo_code_id"
    t.decimal "bonus_amount", precision: 17, scale: 5, default: "0.0"
    t.bigint "admin_user_id"
    t.string "comment"
    t.integer "cashback_type"
    t.index ["admin_user_id"], name: "index_ledgers_on_admin_user_id"
    t.index ["betable_type", "betable_id"], name: "index_ledgers_on_betable_type_and_betable_id"
    t.index ["betable_type", "created_at", "transaction_type"], name: "index_betable_created_t_type"
    t.index ["tracking_id"], name: "index_ledgers_on_tracking_id", unique: true
    t.index ["transfer_record_id"], name: "index_ledgers_on_transfer_record_id"
    t.index ["user_promo_code_id"], name: "index_ledgers_on_user_promo_code_id"
    t.index ["wallet_id"], name: "index_ledgers_on_wallet_id"
  end

  create_table "markets", force: :cascade do |t|
    t.integer "status"
    t.string "name"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_specifier_market"
    t.hstore "specifier_text"
    t.text "settings"
    t.integer "bet_type_id"
    t.integer "play_type_id"
    t.integer "rank"
    t.integer "sport_id"
    t.boolean "enabled", default: true
    t.string "display_name"
    t.string "category"
    t.integer "priority"
    t.index ["bet_type_id"], name: "index_markets_on_bet_type_id"
    t.index ["play_type_id"], name: "index_markets_on_play_type_id"
    t.index ["status"], name: "index_markets_on_status"
    t.index ["uid"], name: "index_markets_on_uid"
  end

  create_table "markets_outcomes", force: :cascade do |t|
    t.bigint "market_id"
    t.bigint "outcome_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_id", "outcome_id"], name: "index_markets_outcomes_on_market_id_and_outcome_id", unique: true
    t.index ["market_id"], name: "index_markets_outcomes_on_market_id"
    t.index ["outcome_id"], name: "index_markets_outcomes_on_outcome_id"
  end

  create_table "match_outcomes", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "outcomeable_id"
    t.bigint "market_id"
    t.decimal "odds"
    t.decimal "probabilities"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "outcomeable_type"
    t.hstore "specifier_text"
    t.string "odd_type"
    t.string "status"
    t.string "match_uid"
    t.string "market_uid"
    t.string "outcomeable_uid"
    t.text "outcome"
    t.json "settings"
    t.index ["market_id"], name: "index_match_outcomes_on_market_id"
    t.index ["match_id"], name: "index_match_outcomes_on_match_id"
    t.index ["match_uid", "market_uid", "outcomeable_uid", "outcomeable_type"], name: "index_match_outcomes_on_uides"
    t.index ["match_uid", "market_uid"], name: "index_match_outcomes_on_match_uid_and_market_uid"
    t.index ["outcomeable_id"], name: "index_match_outcomes_on_outcomeable_id"
  end

  create_table "matches", force: :cascade do |t|
    t.string "uid"
    t.string "status"
    t.datetime "schedule_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sport_id"
    t.bigint "tournament_id"
    t.boolean "enabled", default: false
    t.text "settings"
    t.string "booking_status"
    t.bigint "season_id"
    t.string "actual_status"
    t.text "results"
    t.string "name"
    t.boolean "highlight"
    t.boolean "inplay_subscribed", default: false
    t.boolean "visible", default: true
    t.string "streaming_url"
    t.index ["enabled"], name: "index_matches_on_enabled"
    t.index ["schedule_at"], name: "index_matches_on_schedule_at"
    t.index ["season_id"], name: "index_matches_on_season_id"
    t.index ["sport_id"], name: "index_matches_on_sport_id"
    t.index ["status"], name: "index_matches_on_status"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
    t.index ["uid"], name: "index_matches_on_uid", unique: true
  end

  create_table "mobility_string_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.string "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_string_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_string_translations_on_keys", unique: true
    t.index ["translatable_type", "key", "value", "locale"], name: "index_mobility_string_translations_on_query_keys"
  end

  create_table "mobility_text_translations", force: :cascade do |t|
    t.string "locale", null: false
    t.string "key", null: false
    t.text "value"
    t.string "translatable_type"
    t.bigint "translatable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translatable_id", "translatable_type", "key"], name: "index_mobility_text_translations_on_translatable_attribute"
    t.index ["translatable_id", "translatable_type", "locale", "key"], name: "index_mobility_text_translations_on_keys", unique: true
  end

  create_table "notification_types", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.integer "status", default: 0
    t.index ["kind"], name: "index_notification_types_on_kind"
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "occupations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "occupations_users", force: :cascade do |t|
    t.bigint "occupation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["occupation_id"], name: "index_occupations_users_on_occupation_id"
    t.index ["user_id"], name: "index_occupations_users_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations_users", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organizations_users_on_organization_id"
    t.index ["user_id"], name: "index_organizations_users_on_user_id"
  end

  create_table "outcomes", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_outcomes_on_uid", unique: true
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "betting_pool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wallet_id"
    t.index ["betting_pool_id"], name: "index_participants_on_betting_pool_id"
    t.index ["user_id", "betting_pool_id"], name: "index_participants_on_user_id_and_betting_pool_id", unique: true
    t.index ["user_id"], name: "index_participants_on_user_id"
    t.index ["wallet_id"], name: "index_participants_on_wallet_id"
  end

  create_table "pghero_query_stats", force: :cascade do |t|
    t.text "database"
    t.text "user"
    t.text "query"
    t.bigint "query_hash"
    t.float "total_time"
    t.bigint "calls"
    t.datetime "captured_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["database", "captured_at"], name: "index_pghero_query_stats_on_database_and_captured_at"
  end

  create_table "play_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "popups", force: :cascade do |t|
    t.string "title"
    t.string "screen"
    t.string "name"
    t.string "platform"
    t.string "repeat_type"
    t.integer "repeat_duration"
    t.string "link"
    t.boolean "redirection", default: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
    t.string "country_ids", default: [], array: true
    t.text "structure"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promo_codes", force: :cascade do |t|
    t.string "name"
    t.string "code", null: false
    t.integer "percent", default: 0
    t.integer "kind", default: 0
    t.integer "status", default: 0
    t.datetime "valid_till"
    t.integer "limit_per_user"
    t.integer "usage_limit"
    t.text "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "valid_from"
    t.integer "promo_type", default: 0
    t.index ["code"], name: "index_promo_codes_on_code", unique: true
  end

  create_table "referrals", force: :cascade do |t|
    t.float "reward_amount"
    t.float "threshold_amount"
    t.integer "status", default: 0
    t.bigint "user_id", null: false
    t.bigint "referrer_id", null: false
    t.index ["referrer_id"], name: "index_referrals_on_referrer_id"
    t.index ["user_id"], name: "index_referrals_on_user_id", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.string "uid"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sport_id"
    t.bigint "tournament_id"
    t.index ["sport_id"], name: "index_seasons_on_sport_id"
    t.index ["tournament_id"], name: "index_seasons_on_tournament_id"
    t.index ["uid"], name: "index_seasons_on_uid", unique: true
  end

  create_table "security_answers", force: :cascade do |t|
    t.string "answer"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "security_question_id"
    t.index ["security_question_id"], name: "index_security_answers_on_security_question_id"
    t.index ["user_id"], name: "index_security_answers_on_user_id"
  end

  create_table "security_questions", force: :cascade do |t|
    t.string "question"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "session_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_session_logs_on_user_id"
  end

  create_table "session_transactions", force: :cascade do |t|
    t.decimal "amount", null: false
    t.string "currency"
    t.string "game_uuid", null: false
    t.string "player_id", null: false
    t.string "transaction_id"
    t.string "session_id"
    t.string "bet_type"
    t.string "bet_transaction_id"
    t.string "free_spin_id"
    t.integer "quantity"
    t.string "status", default: "success"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "wallet_balance"
    t.decimal "utilized_bonus", precision: 17, scale: 5, default: "0.0"
    t.string "ref_transaction_id"
    t.integer "game_type", default: 0
    t.string "game_session_id"
  end

  create_table "slot_games", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name"
    t.string "image"
    t.string "provider"
    t.boolean "has_free_rounds"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_featured", default: false
  end

  create_table "soccer_match_scores", force: :cascade do |t|
    t.string "match_status"
    t.string "home_score"
    t.string "away_score"
    t.hstore "clock"
    t.hstore "period_scores"
    t.hstore "statistics"
    t.string "home_corners"
    t.string "away_corners"
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_corners"], name: "index_soccer_match_scores_on_away_corners"
    t.index ["clock"], name: "index_soccer_match_scores_on_clock", using: :gin
    t.index ["home_corners"], name: "index_soccer_match_scores_on_home_corners"
    t.index ["match_id"], name: "index_soccer_match_scores_on_match_id"
    t.index ["period_scores"], name: "index_soccer_match_scores_on_period_scores", using: :gin
    t.index ["statistics"], name: "index_soccer_match_scores_on_statistics", using: :gin
  end

  create_table "sport_countries", force: :cascade do |t|
    t.integer "sport_id"
    t.integer "country_id"
    t.integer "number_of_matches", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rank"
    t.index ["sport_id", "country_id"], name: "index_sport_countries_on_sport_id_and_country_id", unique: true
  end

  create_table "sport_markets", force: :cascade do |t|
    t.bigint "sport_id"
    t.bigint "market_id"
    t.integer "priority"
    t.boolean "visible", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_id"], name: "index_sport_markets_on_market_id"
    t.index ["sport_id"], name: "index_sport_markets_on_sport_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "name"
    t.integer "status", null: false
    t.string "acronym"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled", default: true
    t.integer "number_of_matches", default: 0
    t.integer "rank"
    t.string "kind"
    t.index ["acronym"], name: "index_sports_on_acronym"
    t.index ["enabled"], name: "index_sports_on_enabled"
    t.index ["status"], name: "index_sports_on_status"
    t.index ["uid"], name: "index_sports_on_uid", unique: true
  end

  create_table "team_players", force: :cascade do |t|
    t.string "name"
    t.string "player_type"
    t.string "nationality"
    t.string "gender"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.string "full_name"
    t.datetime "dob"
    t.string "country_code"
    t.string "jersey_number"
    t.integer "age", default: 0
    t.index ["team_id"], name: "index_team_players_on_team_id"
    t.index ["uid"], name: "index_team_players_on_uid", unique: true
  end

  create_table "team_tournaments", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "tournament_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id", "tournament_id"], name: "index_team_tournaments_on_team_id_and_tournament_id"
    t.index ["team_id"], name: "index_team_tournaments_on_team_id"
    t.index ["tournament_id"], name: "index_team_tournaments_on_tournament_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "country_name"
    t.string "acronym"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sport_id"
    t.index ["sport_id"], name: "index_teams_on_sport_id"
    t.index ["uid"], name: "index_teams_on_uid", unique: true
  end

  create_table "tennis_match_scores", force: :cascade do |t|
    t.string "status"
    t.string "reporting"
    t.string "match_status"
    t.string "home_score"
    t.string "away_score"
    t.string "home_gamescore"
    t.string "away_gamescore"
    t.string "current_server"
    t.string "tiebreak"
    t.hstore "period_scores"
    t.bigint "match_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_gamescore"], name: "index_tennis_match_scores_on_away_gamescore"
    t.index ["away_score"], name: "index_tennis_match_scores_on_away_score"
    t.index ["home_gamescore"], name: "index_tennis_match_scores_on_home_gamescore"
    t.index ["home_score"], name: "index_tennis_match_scores_on_home_score"
    t.index ["match_id"], name: "index_tennis_match_scores_on_match_id"
    t.index ["period_scores"], name: "index_tennis_match_scores_on_period_scores", using: :gin
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.boolean "enabled", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topics_users", force: :cascade do |t|
    t.bigint "topic_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_topics_users_on_topic_id"
    t.index ["user_id"], name: "index_topics_users_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.string "uid"
    t.bigint "sport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "enabled", default: true
    t.string "category_name"
    t.jsonb "settings"
    t.integer "tournament_type", default: 0
    t.integer "rank"
    t.string "display_name"
    t.integer "country_id"
    t.integer "number_of_matches", default: 0
    t.index ["enabled"], name: "index_tournaments_on_enabled"
    t.index ["sport_id"], name: "index_tournaments_on_sport_id"
    t.index ["uid", "country_id"], name: "index_tournaments_on_uid_and_country_id", unique: true
    t.index ["uid"], name: "index_tournaments_on_uid"
  end

  create_table "transfer_records", force: :cascade do |t|
    t.integer "payor_id"
    t.integer "payee_id"
    t.integer "merchant_id"
    t.string "message"
    t.float "amount"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "commision_earned"
    t.float "actual_transfer"
    t.integer "kind", default: 0
  end

  create_table "user_promo_codes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "promo_code_id"
    t.integer "status", default: 0
    t.integer "cashback_value"
    t.index ["promo_code_id"], name: "index_user_promo_codes_on_promo_code_id"
    t.index ["user_id"], name: "index_user_promo_codes_on_user_id"
  end

  create_table "user_transactions", force: :cascade do |t|
    t.string "transaction_type"
    t.float "amount"
    t.integer "user_id"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "settings"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "date_of_birth"
    t.string "username"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.boolean "enabled", default: true
    t.time "reality_check_timer"
    t.datetime "exclusion_time"
    t.integer "admin_user_id"
    t.string "zone_name"
    t.string "enabled_by"
    t.string "phone_number"
    t.string "state"
    t.string "phone"
    t.string "kyc_status", default: "NotDone"
    t.integer "deposit_count", default: 0
    t.integer "two_factor_status", default: 0
    t.boolean "deposit_address_request", default: false
    t.boolean "is_betting_allowed", default: true
    t.datetime "last_activity_at"
    t.string "unverified_phone"
    t.string "user_number"
    t.string "disabled_sport_ids", default: [], array: true
    t.string "referral_code"
    t.datetime "discarded_at"
    t.datetime "deposit_limit_updated_at"
    t.datetime "bet_limit_updated_at"
    t.boolean "subscribed_to_notifications", default: true
    t.datetime "admin_updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "user_type", default: 0
    t.string "metamask_address"
    t.string "login_token"
    t.string "deposit_address"
    t.string "deposit_key"
    t.string "otp"
    t.datetime "otp_created_at"
    t.boolean "upcoming_event_notification", default: true
    t.boolean "promotional_notification", default: true
    t.boolean "withdrawal_request_notification", default: true
    t.boolean "security_changes_notification", default: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["referral_code"], name: "index_users_on_referral_code", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.string "city_name"
    t.string "country_name"
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "continent"
    t.string "country_code"
    t.index ["match_id"], name: "index_venues_on_match_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.float "available_amount", default: 0.0
    t.integer "wallet_type", default: 0
    t.boolean "is_current", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "usable_id"
    t.string "usable_type"
    t.integer "currency"
    t.float "wagered_amount", default: 0.0
    t.float "withdrawable_amount", default: 0.0
    t.decimal "betting_bonus", precision: 17, scale: 5, default: "0.0"
    t.decimal "casino_bonus", precision: 17, scale: 5, default: "0.0"
    t.float "losing_bonus_amount", default: 0.0
    t.index ["created_at"], name: "index_wallets_on_created_at"
    t.index ["usable_id", "usable_type"], name: "index_wallets_on_usable_id_and_usable_type"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "accumulator_bets", "users"
  add_foreign_key "accumulator_bets", "wallets"
  add_foreign_key "addresses", "users"
  add_foreign_key "bets", "users"
  add_foreign_key "bets", "wallets"
  add_foreign_key "competitors", "matches"
  add_foreign_key "competitors", "teams"
  add_foreign_key "cricket_match_scores", "matches"
  add_foreign_key "favourites", "users"
  add_foreign_key "languages_users", "languages"
  add_foreign_key "languages_users", "users"
  add_foreign_key "ledgers", "admin_users"
  add_foreign_key "ledgers", "user_promo_codes"
  add_foreign_key "ledgers", "wallets"
  add_foreign_key "match_outcomes", "markets"
  add_foreign_key "match_outcomes", "matches"
  add_foreign_key "matches", "seasons"
  add_foreign_key "matches", "sports"
  add_foreign_key "matches", "tournaments"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "referrals", "users"
  add_foreign_key "referrals", "users", column: "referrer_id"
  add_foreign_key "seasons", "sports"
  add_foreign_key "seasons", "tournaments"
  add_foreign_key "security_answers", "security_questions"
  add_foreign_key "security_answers", "users"
  add_foreign_key "session_logs", "users"
  add_foreign_key "soccer_match_scores", "matches"
  add_foreign_key "team_players", "teams"
  add_foreign_key "team_tournaments", "teams"
  add_foreign_key "team_tournaments", "tournaments"
  add_foreign_key "teams", "sports"
  add_foreign_key "tennis_match_scores", "matches"
  add_foreign_key "user_promo_codes", "promo_codes"
  add_foreign_key "user_promo_codes", "users"
  add_foreign_key "wallets", "users"
end
