require 'will_paginate/array'
class Admin::ReportsController < Admin::BaseController
  skip_load_and_authorize_resource
  before_action :set_date_filter, only: [:sports, :casino_report_by_games, :slot_game_report_by_games]
  before_action :set_game, only: [:casino_report_by_games, :slot_game_report_by_games]
  before_action :set_slot_game, only: [:slot_game_report_by_games]

  def bets
    @bets = query.present? ? Bet.not_combo : Bet.not_combo.today_bets
    filter_bets if query.present?
    @bets = @bets.order_by_recent
    @bets = @bets.paginate(page: params[:page], per_page: Constants::PER_PAGE) unless params[:format].eql?('csv')
    respond_to do |format|
      format.csv { send_data @bets.to_csv, filename: "Bets Report #{Time.zone.now}.csv" }
      format.html
      format.js
    end
  end

  def combo_bets
    @combo_bets = query.present? ? ComboBet : ComboBet.today_combo_bets
    filter_combo_bets if query.present?
    @combo_bets = @combo_bets.distinct.order_by_recent
    @combo_bets = @combo_bets.paginate(page: params[:page], per_page: Constants::PER_PAGE) unless params[:format].eql?('csv')
    respond_to do |format|
      format.csv { send_data @combo_bets.to_csv, filename: "Bets Report #{Time.zone.now}.csv" }
      format.html
      format.js
    end
  end

  def sports
    @sports = Report::Sports.new(
                start_date: @start_date || Date.today,
                end_date: @end_date || Date.today,
                play_type: params[:play_type].presence
              )
    @sports = @sports.call unless params[:format].eql?('csv')
    respond_to do |format|
      format.csv { send_data @sports.to_csv, filename: "Sports Report #{Time.zone.now}.csv" }
      format.html
      format.js
    end
  end

  def payments
    @ledgers = query.present? ? Ledger.inner_join_users : Ledger.inner_join_users.todays_ledgers
    filter_payments if query.present?
    @ledgers = @ledgers.order_by_recent
                       .select('ledgers.id, ledgers.transaction_type, ledgers.amount, ledgers.created_at, users.id as user_id, wallets.currency as currency, users.user_number as user_number, ledgers.remark, ledgers.status, ledgers.mode, ledgers.wallet_id, ledgers.admin_user_id')
    @ledgers = @ledgers.paginate(page: params[:page], per_page: Constants::PER_PAGE) unless params[:format].eql?('csv')
    respond_to do |format|
      format.csv { send_data to_csv_by_payments(ledgers: @ledgers), filename: "Payments report #{Time.zone.now}.csv" }
      format.html
      format.js
    end
  end

  def payments_by_region
    @ledgers = Ledger.inner_join_user_address
    filter_payments_by_region if params[:query].present?
    @ledgers = @ledgers.order_by_recent
                       .select('ledgers.created_at, ledgers.mode, addresses.country as region, wallets.currency as currency, users.user_number as user_number, users.id as user_id, ledgers.amount, ledgers.transaction_type, ledgers.wallet_id')
    @ledgers = @ledgers.paginate(page: params[:page], per_page: Constants::PER_PAGE) unless params[:format].eql?('csv')
    respond_to do |format|
      format.csv { send_data to_csv_by_region(ledgers: @ledgers), filename: "Payments by region #{Time.zone.now}.csv" }
      format.html
      format.js
    end
  end

  def deposits
    @ledgers = Ledger.deposits
                     .inner_join_user_address
    filter_deposits if params[:query].present?
    @ledgers = @ledgers.order_by_recent
                       .select('ledgers.id, ledgers.amount, ledgers.created_at, users.id as user_id, users.user_number as user_number, wallets.currency as currency, wallets.id as wallet_id, ledgers.remark, addresses.country as region, ledgers.status, ledgers.mode')
    @ledgers = @ledgers.paginate(page: params[:page], per_page: Constants::PER_PAGE) unless params[:format].eql?('csv')
    respond_to do |format|
      format.csv { send_data to_csv_by_deposits(ledgers: @ledgers), filename: "Payments by region #{Time.zone.now}.csv" }
      format.html
      format.js
    end
  end

  def casino
    @transactions = SessionTransaction.casino.joins_casino_item
    if query.present?
      @transactions = @transactions.where('casino_items.id = ?', query[:game_id]) if query[:game_id].present?
      filter_casino_transactions
    end
    @transactions = @transactions.select('session_transactions.created_at,
                                   users.id as user_id,
                                   users.first_name,
                                   users.last_name,
                                   casino_menus.name as category,
                                   casino_items.name as game,
                                   casino_items.provider,
                                   session_transactions.bet_type,
                                   session_transactions.amount,
                                   ledgers.transaction_type'
                                 )
                                 .paginate(page: params[:page], per_page: Constants::PER_PAGE)
  end

  def slot_game
    @transactions = SessionTransaction.slot_game.joins_slot_game
    if query.present?
      @transactions = @transactions.where('slot_games.id = ?', query[:game_id]) if query[:game_id].present?
      filter_casino_transactions
    end
    @transactions = @transactions.select('session_transactions.created_at,
                                   users.id as user_id,
                                   users.first_name,
                                   users.last_name,
                                   slot_games.name as game,
                                   slot_games.provider,
                                   session_transactions.bet_type,
                                   session_transactions.amount,
                                   ledgers.transaction_type'
                                 )
                                 .paginate(page: params[:page], per_page: Constants::PER_PAGE)
  
  end

  def casino_report_by_games
    @games = Report::Casino.new(
      start_date: @start_date || Date.today,
      end_date: @end_date || Date.today,
      game: @game,
      page: params[:page] || 1
    )
    render_game_response
  end

  def slot_game_report_by_games
    @games = Report::SlotGames.new(
      start_date: @start_date || Date.today,
      end_date: @end_date || Date.today,
      game: @game,
      page: params[:page] || 1
    )
    render_game_response
  end

  def render_game_response
    unless params[:format].eql?('csv')
      @games = @games.call
      @games = @games.paginate(page: params[:page], per_page: Constants::PER_PAGE)
      # @games_pages = CasinoItem.pluck(:id).paginate(page: params[:page], per_page: Constants::PER_PAGE)
    end
    respond_to do |format|
      format.csv { send_data to_csv_casino_reports_by_game(games: @games.call), filename: "casino_report_by_game_#{Time.zone.now}.csv" }
      format.html
      format.js
    end
  end

  private

  def to_csv_casino_reports_by_game(games:)
    attributes = ["Game", "Provider", "Total Bet", "Winnings", "P/L", "GGR", "Average Bet", "Bonus Utilized"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      games.each do |game|
        csv << [game.name, game.provider, game.stakes, game.winning, game.pl, game.ggr, game.average_stake, game.bonus_utilized] 
      end
    end
  end

  def to_csv_by_region(ledgers:)
    attributes = ["DateTime", "Region Name", "Player ID", "Currency", "Amount", "Transaction Type", "Payment Type"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      ledgers.each do |ledger|
        csv << [current_time(ledger.created_at), ledger.region, ledger.user_number, ledger.wallet.currency, ledger.amount.abs, ledger.transaction_type, ledger.mode&.titleize] 
      end
    end
  end

  def to_csv_by_deposits(ledgers:)
    attributes = ["Transaction ID", "Amount", "DateTime", "Player ID", "Remark", "Region", "Status", "Payment System"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      ledgers.each do |ledger|
        csv << [ledger.id, ledger.amount, current_time(ledger.created_at), ledger.user_number, ledger.remark, ledger.region, ledger.status, ledger.mode || 'NA'] 
      end
    end
  end

  def to_csv_by_payments(ledgers:)
    attributes = ["Transaction ID", "Player ID", "Date and Time", "Currency", "Amount", "Transaction Type", "Payment Mode", "Region", "Remarks", "Status"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      ledgers.each do |ledger|
        csv << [ledger.id, ledger.user_number, current_time(ledger.created_at), ledger.wallet.currency, ledger.amount, ledger.transaction_type, ledger.mode || 'NA', ledger.region, ledger.remark, ledger.status]
      end
    end
  end

  def filter_casino_transactions
    @transactions = @transactions.where('users.user_number = ?', query[:player_number]) if query[:player_number].present?
    @transactions = @transactions.where(bet_type: query[:bet_type]) if query[:bet_type].present?
    @transactions = @transactions.where('ledgers.transaction_type = ?', query[:transaction_type]) if query[:transaction_type].present?
    @transactions = @transactions.between(query[:start_date].to_date, query[:end_date].to_date) if query[:filter_date].present?
  end

  def filter_deposits
    @ledgers = @ledgers.where(id: query[:transaction_id]) if query[:transaction_id].present?
    @ledgers = @ledgers.where('users.user_number ILIKE ?', "%#{query[:player_id].strip}%") if query[:player_id].present?
    @ledgers = @ledgers.send(query[:status]) if query[:status].present?
    @ledgers = @ledgers.between(query[:start_date].to_date, query[:end_date].to_date) if query[:filter_date].present?
    @ledgers = @ledgers.send(query[:payment_type]) if query[:payment_type].present?
    @ledgers = @ledgers.search_by_region(query[:region]) if query[:region].present?
    @ledgers = filter_by_amount(ledgers: @ledgers) if query[:min_amt].present? || query[:max_amt].present?
  end

  def filter_payments
    @ledgers = @ledgers.where(id: query[:transaction_id]) if query[:transaction_id].present?
    @ledgers = @ledgers.where('users.user_number ILIKE ?', "%#{query[:player_id].strip}%") if query[:player_id].present?
    @ledgers = @ledgers.send(query[:status]) if query[:status].present?
    @ledgers = @ledgers.between(query[:start_date].to_date || Date.today, query[:end_date].to_date || Date.today) #if query[:filter_date].present?
    @ledgers = @ledgers.send(query[:payment_mode]) if query[:payment_mode].present?
    @ledgers = @ledgers.send(query[:payment_type]) if query[:payment_type].present?
    @ledgers = @ledgers.send(query[:transaction_type]) if query[:transaction_type].present?
    # @ledgers = @ledgers.search_by_region(query[:region]) if query[:region].present?
    @ledgers = filter_by_amount(ledgers: @ledgers) if query[:min_amt].present? || query[:max_amt].present?
  end

  def filter_by_amount(ledgers:)
    return ledgers.search_by_amount(query[:min_amt], query[:max_amt]) if query[:min_amt].present? && query[:max_amt].present?
    return ledgers.filter_from_amount(query[:min_amt]) if query[:min_amt].present?
    ledgers.filter_to_amount(query[:max_amt]) if query[:max_amt].present?
  end

  def filter_payments_by_region
    @ledgers = @ledgers.between(query[:start_date].to_date, query[:end_date].to_date) if query[:filter_date].present?
    @ledgers = @ledgers.send(query[:payment_type]) if query[:payment_type].present?
    @ledgers = @ledgers.send(query[:operation]) if query[:operation].present?
    @ledgers = @ledgers.search_by_region(query[:region]) if query[:region].present?
  end

  def filter_combo_bets
    # @combo_bets = @combo_bets.joins(user: :address, bets: :match)
    @combo_bets = @combo_bets.joins(:user, bets: :match)
    @combo_bets = @combo_bets.between(query[:start_date].to_date || Date.today, query[:end_date].to_date || Date.today) #if query[:filter_date].present?
    @combo_bets = @combo_bets.where(matches: { sport_id: query[:sport_id] }) if query[:sport_id].present?
    @combo_bets = @combo_bets.where(bets: { tournament_id: query[:tournament_id] }).distinct if query[:tournament_id].present?
    @combo_bets = @combo_bets.where(bets: { match_id: query[:match_id] }) if query[:match_id].present?
    # @combo_bets = @combo_bets.where(addresses: { country: query[:country_name] }) if query[:country_name].present?
    @combo_bets = filter_bet_stakes(bets: @combo_bets) if query[:stake_min_amt].present? || query[:stake_max_amt].present?
    @combo_bets = filter_bet_winnings(bets: @combo_bets) if query[:winning_min_amt].present? || query[:winning_max_amt].present?
  end

  def filter_bets
    # @bets = @bets.joins(:match, user: :addresses)
    @bets = @bets.joins(:match, :user)
    @bets = @bets.between(query[:start_date].to_date || Date.today, query[:end_date].to_date || Date.today) #if query[:filter_date].present?
    @bets = filter_bet_stakes(bets: @bets) if query[:stake_min_amt].present? || query[:stake_max_amt].present?
    @bets = filter_bet_winnings(bets: @bets) if query[:winning_min_amt].present? || query[:winning_max_amt].present?
    @bets = @bets.where(matches: { sport_id: query[:sport_id] }) if query[:sport_id].present?
    @bets = @bets.where(match_id: query[:match_id]) if query[:match_id].present?
    @bets = @bets.where(tournament_id: query[:tournament_id]) if query[:tournament_id].present?
    # @bets = @bets.where(addresses: { country: query[:country_name] }) if query[:country_name].present?
  end

  def filter_bet_stakes(bets:)
    return bets.search_by_stake(query[:stake_min_amt], query[:stake_max_amt]) if query[:stake_min_amt].present? && query[:stake_max_amt].present?
    return bets.filter_from_stake(query[:stake_min_amt]) if query[:stake_min_amt].present?
    bets.filter_to_stake(query[:stake_max_amt]) if query[:stake_max_amt].present?
  end

  def filter_bet_winnings(bets:)
    return bets.filter_between_winnings(query[:winning_min_amt], query[:winning_max_amt]) if query[:winning_min_amt].present? && query[:winning_max_amt].present?
    return bets.filter_from_winnings(query[:winning_min_amt]) if query[:winning_min_amt].present?
    bets.filter_to_winnings(query[:winning_max_amt]) if query[:winning_max_amt].present?
  end

  def query
    @query ||= params[:query]
  end

  def set_date_filter
    return unless params[:start_date] && params[:end_date]

    @start_date = params[:start_date].to_time
    @end_date = params[:end_date].to_time
  end
  
  def set_game
    @game = CasinoItem.find_by(id: params[:game_id])
  end 

  def set_slot_game
    @game = SlotGame.find_by(id: params[:game_id])
  end
end
