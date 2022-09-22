# Constants module to hold all constants
module Constants
  # TODO : Need to seperate per page for admin
  # MAX_PER_DAY_WINNING = 40000
  SLIP_SELECTING_LIMIT = 30
  MAX_BET_SHOW_COUNT = 10

  PERPAGE = 200
  SOCCER_LEAGUES = %w[eu other intl].freeze
  UK_COUNTRY_CODES = { ENG: 'england', KOS: 'kosovo', SCO: 'scotland', NIR: 'northern ireland', WAL: 'wales' }.freeze
  # This will be for fetching next n days scheduled matches and their information
  SCHEDULE_DURATION = 7

  SUPPORTED_SPORTS = { '8PVLtc' => 'soccer', '7oQIiL' => 'tennis',
                       '8DRloB' => 'basket', '5XBNWp' => 'hockey',
                       '5ShGNo' => 'handball', '7NvHfz' => 'volleyball' }.freeze

  # LSPORTS_SUPPORTED_SPORTS = { 6046 => 'Football', 54094 => 'Tennis',
  #                              687888 => 'Horse Racing', 452674 => 'Cricket',
  #                              530129 => 'Hockey', 274792 => 'Rugby League',
  #                              48242 => 'Basketball', 131506 => 'American Football',
  #                              687889 => 'Golf', 154919 => 'Boxing',
  #                              687890 => 'E-Games', 154914 => 'Baseball', 265917 => 'Table Tennis',
  #                              687887 => 'Futsal', 1149113 => 'Bowls', 1149093 => 'Badminton',
  #                              35232 => 'Ice Hockey', 35709 => 'Handball', 154830 => 'Volleyball', 154923 => 'Darts'
  #                             }.freeze

  LSPORTS_SUPPORTED_SPORTS = { 6046 => 'Football', 54094 => 'Tennis',
                               530129 => 'Hockey', 48242 => 'Basketball',
                               154919 => 'Boxing'
                              }.freeze

  LSPORTS_STATISTIC_MAP = { 1 => 'Corners', 6 => 'Yellow cards', 7 => 'Red cards',
                            8 => 'Penalties', 9 => 'Goal', 10 => 'Substitutions',
                            24 => 'Own goal', 25 => 'Penalty goal', 40 => 'Missed penalty',
                            20 => 'Aces', 21 => 'Double faults', 34 => 'First serve wins',
                            12 => 'Fouls', 28 => 'Two points', 30 => 'Three points',
                            31 => 'Time outs', 32 => 'Free throws' }.freeze

  LSPORTS_PERIOD_MAP = { -1 => 'NSY', 80 => 'Break Time', 99 => 'None',
                          1 => '1st', 2 => '2nd', 3 => '3rd', 4 => '4th', 5 => '5th',
                          10 => '1st Half', 20 => '2nd Half', 30 => 'Overtime 1st Half',
                          35 => 'Overtime 2nd Half', 40 => 'Overtime', 50 => 'Penalties',
                          60 => 'Game', 65 => 'Round', 70 => 'Over', 71 => 'Delivery',
                          100 => 'Full time', 101 => 'Full time after overtime',
                          102 => 'Full time after penalties' }.freeze

  LSPORTS_LANGUAGE_MAP = { :en => 'en', :ru => 'ru', :cz => 'cz' }

  CASINO_LANGUAGE_MAP = { :en => 'en', :ru => 'ru', :cz => 'cn' }

  SLOT_LANGUAGE_MAP = { :en => 'en', :ru => 'ru', :cz => 'zh' }

  ALLOWED_PERIODS = %w[week day month year].freeze

  MATCH_ENDED_STATUSES = %w[3 4].freeze
  MATCH_BETTING_ALLOWED_STATUS = %w[0 1].freeze

  LEADERBOARD_MINIMUM_CRITERIA_BETS = 25

  MINIMUM_TRANSFERABLE_AMOUNT = 0

  INPLAY_URL = '/listen/inplay_soccer'.freeze

  SOCCER_SUPPORTED_MARKETS = %w[
    1 7 8 9 10 11 12 13 14 15 18 19 20 21 23 24 26 27 28 31 32 33 34 45 48 49
    60 61 62 63 64 65 68 69 70 71 72 73 74 76 77 83 84 85 86 87 90 91 92 93 94
    96 97 102 103 104 105 106 107 108 109 110 136 137 139 140 141 142 143 144
    149 150 152 153 154 155 156 157 162 163 164 166 167 168 172 173 174 175 177
    178 179 183 565 566 568 569 570 571 572 573 575 576 577 578 579 580 582 583
    584 585 586 587 591 592 596 597 770 775 776 777 778 779 780
  ].freeze

  SOCCER_SUPPORTED_PLAYER_MARKETS = %w[770 775 776 777 778 779 780].freeze

  CRICKET_SCORE_ATTRIBUTES = %w[
    status status reporting match_status home_score away_dismissals away_score
    innings over home_penalty_runs away_penalty_runs home_dismissals delivery
  ].freeze

  SOCCER_SCORE_ATTRIBUTES = %w[
    match_status home_score away_score clock period_scores
  ].freeze

  TENNIS_SCORE_ATTRIBUTES = %w[
    status reporting match_status home_score away_score home_gamescore
    away_gamescore current_server tiebreak period_scores
  ].freeze

  # Will be changed according to tennis markets. Currently we are storing similar markets of soccer
  TENNIS_SUPPORTED_MARKETS = %w[
    # 1 18 10 29 16 547 83 482 60 293 610 473 22 349 392 19 20 167 168 140 141 68
    69 70 90 91 92 119 293 68 90 47 105 50 167 168 177 178 179 53 54 546 11 612
  ].freeze

  # Will be changed according to cricket markets. Currently we are storing similar markets of soccer
  CRICKET_SUPPORTED_MARKETS = %w[
    1 18 10 29 16 547 83 482 60 293 610 473 22 349 392 19 20 167 168 140 141 68
    69 70 90 91 92 119 293 68 90 47 105 50 167 168 177 178 179 53 54 546 11 612
  ].freeze

  CACHE_EXPIRE_TIME = 3 # in days

  # Envirenment spacific
  ODDS_UPDATE_CHANNEL = "#{Rails.env}_match_odds_change".freeze
  SCORE_UPDATE_CHANNEL = "#{Rails.env}_match_score_change".freeze
  STATUS_UPDATE_CHANNEL = "#{Rails.env}_match_status_change".freeze
  TOP_MARKETS_CHANNEL = "#{Rails.env}_top_market_odds_change".freeze
  ODDS_SNAPSHOT_CHANNEL = "l_event".freeze
  INPLAY_EVENT_RECORD_CHANNEL = "live_event_records/record_dict".freeze
  # ODDS_SNAPSHOT_CHANNEL = "#{Rails.env}_match_odds_snapshot".freeze


  ODDS_CHANGE_CHANNEL = "#{Rails.env}_match_odds_change".freeze
  WALLET_UPDATE_CHANNEL = "#{Rails.env}_wallet_update".freeze

  PLAYER_ODDS_CHANGE_CHANNEL = 'match_player_odds_change'.freeze
  MATCH_SCORE_CHANNEL = 'match_score_change'.freeze
  BET_STOP_CHANNEL = 'bet_stop'.freeze

  COMPULSORY_WALLET_TYPES = %w[point].freeze

  POINT_WALLET_JOINING_AMOUNT = 2_000
  BETTING_POOL_WALLET_JOINING_AMOUNT = 2_000
  CURRENCY_WALLET_JOINING_AMOUNT = 0

  ALLOWED_COUNTRY_CODES = %w[
    MLT
  ].freeze

  REGISTRATION_COUNTRY_FIELDS = %w[name alpha2 alpha3 country_code]

  ODDS_FORMATE = %w[American Fractional Decimal].freeze

  ALLOWED_SOCCER_TOURNAMENT = %w[sr:tournament:17].freeze

  GAMECAST_BASE_URL = 'https://s5dev.sir.sportradar.com/gammabet/en/1/'.freeze

  PLAYER_MARKETS_OUTCOMES_EXPIRY_DURATION = 3 # Days after which player outcomes for a match are deleted from db

  PLAYER_BET_TYPES = %w[lines].freeze # BetTypes for player markets

  PREMATCH_MARKETS = %w[1 2 3 4 5 6 7 8 41 42 43 13 14 15 16 17 18 19].freeze
  INPLAY_MARKETS = %w[1777 10115 10161 10124 10568 1778 1780 10563 10565 50461].freeze
  SPECIFIRE_MARKETS = %w[2 10124 10568 1778 1780].freeze

  KYC_STATUS = %w[NotDone Approved Pending Rejected].freeze
  CASINO_TYPE = %w[non_live live].freeze

  SPECIFIRES = %i[total handicap].freeze

  PREGAME_MARKETS = ['Goals Odd Even', 'Home Team Odd Even Goals', 'Away Team Odd Even Goals', 'Half Time Result', 'Half Time Double Chance', 'Half Time Correct Score', '1st Half Goals Odd Even', 'Home Team Highest Scoring Half', 'Away Team Highest Scoring Half', '2nd Half Goals Odd Even', 'Match Winner', 'Double Chance', 'Correct Score', 'Asian Handicap', 'HT/FT Double', 'Both Teams To Score', 'Handicap Result', 'Highest Scoring Half', 'Handicap Result 1st Half', 'Asian Handicap First Half', 'Double Chance - 1st Half', 'Both Teams To Score - 1st Half', 'Both Teams To Score - 2nd Half'].freeze

  HALF_TIME_PREGAME_MARKETS = ['Half Time Result', 'Half Time Double Chance', 'Half Time Correct Score', '1st Half Goals Odd Even', 'Handicap Result 1st Half', 'Asian Handicap First Half', 'Double Chance - 1st Half', 'Both Teams To Score - 1st Half'].freeze

  FULL_TIME_PREGAME_MARKETS = ['Goals Odd Even',  'Home Team Odd Even Goals', 'Away Team Odd Even Goals', 'Home Team Highest Scoring Half', 'Away Team Highest Scoring Half', '2nd Half Goals Odd Even', 'Match Winner', 'Double Chance', 'Correct Score', 'Asian Handicap', 'HT/FT Double', 'Both Teams To Score', 'Handicap Result', 'Highest Scoring Half', 'Both Teams To Score - 2nd Half', 'Home/Away'].freeze

  # INPLAY_MARKETS = ["Match Goals", "First Half Goals", "Total Corners", "2-Way Corners", "1st Half Corners", "Alternative Total Corners", "Half Time Correct Score", "Asian Corners", "1st Half Asian Corners", "Both Teams To Score", "Both Teams to Score in 1st Half", "Both Teams to Score in 2nd Half"].freeze

  HALF_TIME_INPLAY_MARKETS = ['First Half Goals', '1st Half Corners', 'Half Time Correct Score', '1st Half Asian Corners', 'Both Teams to Score in 1st Half'].freeze

  FULL_TIME_INPLAY_MARKETS = ['Match Goals', 'Total Corners', '2-Way Corners', 'Alternative Total Corners', 'Asian Corners', 'Both Teams to Score', 'Both Teams to Score in 2nd Half'].freeze

  # ALL_MARKETS = (PREGAME_MARKETS + INPLAY_MARKETS).uniq.freeze

  HALF_TIME_MARKETS = (HALF_TIME_PREGAME_MARKETS + HALF_TIME_INPLAY_MARKETS).uniq.freeze

  FULL_TIME_MARKETS = (FULL_TIME_PREGAME_MARKETS + FULL_TIME_INPLAY_MARKETS).uniq.freeze

  AD_POSITION = %w[Header Left Right].freeze

  TIME_OUT_LIMIT =
    if Rails.env.production?
      ['1 day', '1 week', '1 month', '1 year', 'Indefinite']
    elsif Rails.env.staging?
      ['3 minute', '10 minute', '15 minute', '20 minute', 'Indefinite']
    else
      ['1 minute', '2 minute', '3 minute', '4 minute', 'Indefinite']
    end.freeze

  SUPPORT_EMAILS = %w[support@pedmax.com help@pedmax.com].freeze
  SUPPORT_MESSAGE = "For queries please contact".freeze

  MAXIMUM_REALITY_LIMIT = 60
  REALITY_LIMIT_INTERVAL = 5
  FIREBASE_ODDS_UPDATE_INTERVAL = 1 # IN MINUTES

  ADMIN_BLOCKCHAIN_ADDRESS = Figaro.env.ADMIN_BLOCKCHAIN_ADDRESS
  PROFIT_BET_TPES = %w[win jackpot freespin refund].freeze
  BET_TPES = %w[bet tip freespin win refund jackpot].freeze
  LIVE_CASINO = %w[roulette baccarat poker blackjack lottery table].freeze
  CASINO_CURRENCY = Figaro.env.casino_currency
  CURRENCY = 'ETH'
  CASINO_AVAIALBLE_PROVIDERS = %w[Betgames Booongo Dlv Igrosoft Platipus Tomhorn Betsoft Vivogaming Playson Lucky Endorphina Spinmatic Imagina].freeze
  OVER_UNDER_MARKETS = %w[10124 10568].freeze
  HEADER_MARKETS = ['3-way', 'double chance', 'next goal', 'over under'].freeze
  SELECTED_MARKETS = %w[1 59 1778 2].freeze
  PREMATCH_SELECTED_MARKETS = %w[1 3 1778 2].freeze
  SELECTED_MARKETS_WO_OU = %w[1 3 1777 10115 1778].freeze # without under over
  COMMISION = 0.20
  DEPOSITED_AMOUNT = 300
  MIN_PLAY = 1
  MAX_PLAY = 1000
  CASINO_PROVIDERS_WITHOUT_LOBBIES = %w[Vivogaming].freeze
  LSPORTS_MSG_TYPE = { 'Full' => 0, 'Fixture metadata' => 1, 'Livescore' => 2, 'Market Update' => 3, 'Leagues' => 4, 'Sports' => 5, 'Locations' => 6, 'Markets' => 7, 'Bookmakers' => 8, 'Keep Alive' => 31, 'Heartbeat' => 32, 'Settlements' => 35, 'Snapshot' => 36, 'Outright fixture' => 37, 'Outright Leauge' => 38 }.freeze
  UNAVAILABLE_CASHOUT_MARKETS = %w[4 6 9 11 16 56 71 72 82 84 85 86 98 99 100 128 134 143 144 161 168 199 388 461 595 714 824 881 896 940 998 999 1065 1066 1067 1068].freeze
  SHORT_TIME_MARKETS = %w[16 71 72 82 84 85 86 95 98 99 134 143 144 161 168 171 199 456 523 595 998 999 1030].freeze
  HALF_TIME_42_MARKETS = %w[4 9 21 41 61 64 113 129 836 880].freeze
  LS_PREMATCH_MARKETS = %w[19 71 72 82 208 214 1030 1031].freeze
  MARKET_OUTCOME_ORDER = { '1' => { name: '1X2', outcomes_name: %w[1 X 2], ls_outcomes_name: %w[1 X 2] },
                           '7' => { name: 'double chance', outcomes_name: %w[1X 12 X2], ls_outcomes_name: %w[1X X2 12] },
                           '41' => { name: '1st period winner', outcomes_name: %w[1 X 2], ls_outcomes_name: %w[1 X 2] },
                           '42' => { name: '2nd period winner', outcomes_name: %w[1 X 2], ls_outcomes_name: %w[1 X 2] },
                           '59' => { name: 'next goal', outcomes_name: %w[1 X 2], ls_outcomes_name: ['1', 'No Goal', '2'] },
                           '52' => { name: '12', outcomes_name: %w[1 2], ls_outcomes_name: %w[1 2] } }.freeze

  NOTIFICATION_KIND = {
    :bet => 'bet', :combo_bet => 'combo_bet',
    :withdrawal_settlement => 'withdrawal_settlement',
    :referral_reward => 'referral_reward',
    :promo_code => 'promo_code',
    :favourite_match => 'favourite_match',
    :deposit_request => 'deposit_request',
    :withdrawal_request => 'withdrawal_request',
    :big_win => 'big_win',
    :liability_exceeded => 'liability_exceeded'
  }

  FAVOURITE_TEAM_TOPIC = 'favourite_team'
  ADMIN_NOTIFICATIONS_TOPIC = 'admin_notifications'
  ALL_USERS_TOPIC = 'all_users'
  NOTIFIABLE_STATUSES = %w[won lost refunded cashed_out cancelled]

class << self

    def inplay_top_markets
      {
        '6046' => top_markets(%w[1 2 7 59]), # 'Football',
        '54094' => top_markets(%w[52 202 166]), # 'Tennis',
        '687888' => top_markets(%w[]), # 'Horse Racing', *no matches
        '452674' => top_markets(%w[52 762 41 21]), # 'Cricket',
        '530129' => top_markets(%w[1 2 7 59]), # 'Hockey', *assumptions
        '274792' => top_markets(%w[1 2 52 202]), # 'Rugby League',
        '48242' => top_markets(%w[1 2 7 59]), # 'Basketball',
        '131506' => top_markets(%w[1 2 7 59]), # 'American Football', *assumptions
        '687889' => top_markets(%w[]), # 'Golf', *multiple outcomes
        '154919' => top_markets(%w[1 52]), # 'Boxing',
        #'687890' => top_markets(%w[]), # 'E-Games'
        '68789002' => top_markets(%w[52 202 21]), #"CS:GO"
        '68789004' => top_markets(%w[52]), #"King Of Glory" *no matches
        '68789005' => top_markets(%w[52 1175]), #"League of Legends"
        '68789006' => top_markets(%w[52 202 203 204]), #"Overwatch"
        '68789007' => top_markets(%w[52]), #"Rainbow Six"
        '68789008' => top_markets(%w[52 2]), #"Rocket League"
        '68789009' => top_markets(%w[52 2]), #"StarCraft II"
        '68789010' => top_markets(%w[52]), #"Street Fighter V" *no matches
        '68789011' => top_markets(%w[52]), #"Warcraft III"
        '68789001' => top_markets(%w[52 2 202 203 204]), #"Call of Duty"
        '68789003' => top_markets(%w[1 52]) #"Dota 2

        # '6046' => top_markets(%w[1 7 59 2]),
        # '48242' => top_markets(%w[1 7 59 2]),
        # '154830' => top_markets(%w[1 7 59 2]),
        # '35232' => top_markets(%w[1 7 59 2]),
        # '54094' => top_markets(%w[-1 52 202 166]),
        # '35709' => top_markets(%w[1 7 59 2])
      }
    end

    # Need to update this
    def prematch_top_markets
      {
        '6046' => top_markets(%w[1 2 7 59]), # 'Football',
        '54094' => top_markets(%w[52 202 166]), # 'Tennis',
        '687888' => top_markets(%w[]), # 'Horse Racing', *no matches
        '452674' => top_markets(%w[52 762 41 21]), # 'Cricket',
        '530129' => top_markets(%w[1 2 7 59]), # 'Hockey', *assumptions
        '274792' => top_markets(%w[1 2 52 202]), # 'Rugby League',
        '48242' => top_markets(%w[1 2 7 59]), # 'Basketball',
        '131506' => top_markets(%w[1 2 7 59]), # 'American Football', *assumptions
        '687889' => top_markets(%w[]), # 'Golf', *multiple outcomes
        '154919' => top_markets(%w[1 52]), # 'Boxing',
        #'687890' => top_markets(%w[]), # 'E-Games'
        '68789002' => top_markets(%w[52 202 21]), #"CS:GO"
        '68789004' => top_markets(%w[52]), #"King Of Glory" *no matches
        '68789005' => top_markets(%w[52 1175]), #"League of Legends"
        '68789006' => top_markets(%w[52 202 203 204]), #"Overwatch"
        '68789007' => top_markets(%w[52]), #"Rainbow Six"
        '68789008' => top_markets(%w[52 2]), #"Rocket League"
        '68789009' => top_markets(%w[52 2]), #"StarCraft II"
        '68789010' => top_markets(%w[52]), #"Street Fighter V" *no matches
        '68789011' => top_markets(%w[52]), #"Warcraft III"
        '68789001' => top_markets(%w[52 2 202 203 204]), #"Call of Duty"
        '68789003' => top_markets(%w[1 52]) #"Dota 2
      }
    end

    def format_periods(sport_uid, period)
      if %w[6046 35709].include?(sport_uid)
        soccer_handball_period(period)
      elsif %w[154830 54094].include?(sport_uid)
        tennis_volleyball_period(period)
      elsif sport_uid == '48242'
        basketball_period(period)
      elsif sport_uid == '35232'
        ice_hockey_period(period)
      end
    end

    private

    def soccer_handball_period(period)
      case period
      when 10
        '1st H'
      when 20
        '2nd H'
      when 30
        'O 1st H'
      when 35
        'O 2nd H'
      when 50
        'Penalties'
      when 100
        'FT'
      when 101
        'FT AO'
      when 102
        'FT AP'
      else
        period
      end
    end

    def basketball_period(period)
      case period
      when 1
        '1st Q'
      when 2
        '2nd Q'
      when 3
        '3rd Q'
      when 4
        '4th Q'
      when 40
        'Overtime'
      when 100
        'FT'
      when 101
        'FT AO'
      else
        period
      end
    end

    def tennis_volleyball_period(period)
      case period
      when 1
        '1st S'
      when 2
        '2nd S'
      when 3
        '3rd S'
      when 4
        '4th S'
      when 5
        '5th S'
      when 60
        'Game'
      when 100
        'FT'
      else
        period
      end
    end

    def ice_hockey_period(period)
      case period
      when 1
        '1st P'
      when 2
        '2nd P'
      when 3
        '3rd P'
      when 40
        'Overtime'
      when 50
        'Penalties'
      when 60
        'Game'
      when 100
        'FT'
      when 101
        'FT AO'
      when 102
        'FT AP'
      else
        period
      end
    end

    def top_markets(ids)
      hash = {}
      ids.each do |id|
        hash.merge!(id => market_details(id))
      end
      hash
    end

    def market_details(id)
      case id
      when '1'
        { name: '1X2', outcomes_name: %w[1 X 2], ls_outcomes_name: %w[1 X 2] }
      when '2'
        { name: 'over under', outcomes_name: ['', '+', '-'], ls_outcomes_name: %w[Over Under] }
      when '7'
        { name: 'double chance', outcomes_name: %w[1X 12 X2], ls_outcomes_name: %w[1X 12 X2] }
      when '59'
        { name: 'next goal', outcomes_name: ['1', 'NG', '2'], ls_outcomes_name: ['1', 'No Goal', '2'] }
      # tennis markets started
      when '52'
        { name: '2-way', outcomes_name: %w[1 2], ls_outcomes_name: %w[1 2] }
      when '202'
        { name: '1st Period Winner Home/Away', outcomes_name: %w[1 2], ls_outcomes_name: %w[1 2] }
      when '203'
        { name: '2nt Period Winner Home/Away', outcomes_name: %w[1 2], ls_outcomes_name: %w[1 2] }
      when '204'
        { name: '3rd Period Winner Home/Away', outcomes_name: %w[1 2], ls_outcomes_name: %w[1 2] }
      when '166'
        { name: 'Under/Over Games', outcomes_name: ['', '+', '-'], ls_outcomes_name: %w[Over Under] }
      when '762'
        { name: 'To Win The Toss', outcomes_name: %w[1 2], ls_outcomes_name: %w[1 2] }
      when '21'
        { name: 'Under/Over 1st Period', outcomes_name: ['', '+', '-'], ls_outcomes_name: %w[Over Under] }
      when '41'
        { name: '1st Period Winner', outcomes_name: %w[1 X 2], ls_outcomes_name: %w[1 X 2] }
      when '1175'
        { name: 'Most Kills - 1st Period', outcomes_name: %w[1 2], ls_outcomes_name: %w[1 2] }
      when '-1'
        { name: '', outcomes_name: ['-', '-', '-'], ls_outcomes_name: ['', ''] }
      end
    end
  end

  INPLAY_TOP_MARKETS = {
    'football'=>   { '1'=> '3-way', '7'=> 'double chance', '59'=> 'next goal', '2'=> 'over under' },
    'basketball'=> { '1'=> '3-way', '7'=> 'double chance', '59'=> 'next goal', '2'=> 'over under' },
    'volleyball'=> { '1'=> '3-way', '7'=> 'double chance', '59'=> 'next goal', '2'=> 'over under' },
    'ice hockey'=> { '1'=> '3-way', '7'=> 'double chance', '59'=> 'next goal', '2'=> 'over under' },
    'tennis'=>     { '1'=> '3-way', '7'=> 'double chance', '59'=> 'next goal', '2'=> 'over under' },
    'handball'=>   { '1'=> '3-way', '7'=> 'double chance', '59'=> 'next goal', '2'=> 'over under' }
  }.freeze

  SUPPORTED_CURRENCIES = %w[ETH].freeze

  CURRENCIES = {
    "eth": {
      unit: "Ξ",
      format: "%n %u"
    }
  }

  PER_PAGE = 30
  CASINO_PERPAGE = 16

  TIME_ZONE = 'Moscow'

  RANGE_0 = 0
  RANGE_1 = 10000
  PERCENTAGE_1 = 90
  RANGE_2 = 50000
  PERCENTAGE_2 = 85
  RANGE_3 = Float::INFINITY
  PERCENTAGE_3 = 80

  MAX_MONTHLY_DEPOSIT_LIMIT = 500000000
  MAX_WEEKLY_DEPOSIT_LIMIT = 200000000
  MAX_DAY_DEPOSIT_LIMIT = 50000000
  MAX_SINGLE_LIMIT = 4000000
  MINIMUM_DEPOSIT_AMOUNT = 5000

  MAX_MONTHLY_BET_LIMIT = 200000000000
  MAX_WEEKLY_BET_LIMIT = 50000000000
  MAX_DAILY_BET_LIMIT = 600000000
  MAX_ONE_BET_LIMIT = 1000000

  MAX_BALANCE_LIMIT = 500000
  MAX_LIABILITY_AMOUNT = 50000000

  MAX_AUTO_WITHDRAWAL_LIMIT = 50000
  MAX_WITHDRAWAL_LIMIT = 2000000
  MIN_WITHDRAWAL_LIMIT = 10000

  USER_LIMIT_ATTRIBUTES = %I[max_one_bet_amount max_daily_bet_amount max_weekly_bet_amount max_monthly_bet_amount
    max_single_amount max_day_deposit_amount max_weekly_deposit_amount max_monthly_deposit_amount
  ]

  DEFAULT_SETTINGS = {
    auto_withdrawal_limit: MAX_AUTO_WITHDRAWAL_LIMIT,
    max_one_bet_amount: MAX_ONE_BET_LIMIT,
    max_daily_bet_amount: MAX_DAILY_BET_LIMIT,
    max_weekly_bet_amount: MAX_WEEKLY_BET_LIMIT,
    max_monthly_bet_amount: MAX_MONTHLY_BET_LIMIT,
    max_single_amount: MAX_SINGLE_LIMIT,
    max_day_deposit_amount: MAX_DAY_DEPOSIT_LIMIT,
    max_weekly_deposit_amount: MAX_WEEKLY_DEPOSIT_LIMIT,
    max_monthly_deposit_amount: MAX_MONTHLY_DEPOSIT_LIMIT,
    minimum_deposit_amount: MINIMUM_DEPOSIT_AMOUNT,
    balance_amount_limit: MAX_BALANCE_LIMIT,
    minimum_withdrawal_amount: MIN_WITHDRAWAL_LIMIT,
    maximum_withdrawal_amount: MAX_WITHDRAWAL_LIMIT,
    cashout_allowed: 1,
    cashout_commision: 5,
    top_countries: ["IRQ"],
    registration_enabled_countries: %w(ARE BHR DZA EGY IND IRQ JOR KEN KWT LBN LBY MAR NGA OMN QAT TUN YEM ZAF),
    referral_reward_amount: { 'IQD' => 200 },
    referral_threshold_amount: { 'IQD' => 400},
    big_win_notification_amount: { 'IQD' => 300},
    max_liability_amount: 5000,
    agent_commision: {
      range_1: {
        amount: RANGE_1,
        percentage: PERCENTAGE_1
      },
      range_2: {
        amount: RANGE_2,
        percentage: PERCENTAGE_2
      },
      range_3: {
        amount: RANGE_3,
        percentage: PERCENTAGE_3
      }
    }
  }

  BET_BONUS_MIN_ODDS = 1.3

  BET_BONUS_SETTING = {
                        2=>{:bonus_percentage=>3},
                        3=>{:bonus_percentage=>5},
                        4=>{:bonus_percentage=>7},
                        5=>{:bonus_percentage=>8},
                        6=>{:bonus_percentage=>10},
                        7=>{:bonus_percentage=>10},
                        8=>{:bonus_percentage=>10},
                        9=>{:bonus_percentage=>10},
                        10=>{:bonus_percentage=>10},
                        11=>{:bonus_percentage=>15},
                        12=>{:bonus_percentage=>15},
                        13=>{:bonus_percentage=>15},
                        14=>{:bonus_percentage=>15},
                        15=>{:bonus_percentage=>15},
                        16=>{:bonus_percentage=>20},
                        17=>{:bonus_percentage=>20},
                        18=>{:bonus_percentage=>20},
                        19=>{:bonus_percentage=>20},
                        20=>{:bonus_percentage=>20},
                        21=>{:bonus_percentage=>50},
                        22=>{:bonus_percentage=>50},
                        23=>{:bonus_percentage=>50},
                        24=>{:bonus_percentage=>50},
                        25=>{:bonus_percentage=>50},
                        26=>{:bonus_percentage=>100},
                        27=>{:bonus_percentage=>100},
                        28=>{:bonus_percentage=>100},
                        29=>{:bonus_percentage=>100},
                        30=>{:bonus_percentage=>100}
                      }.freeze

  DEFAULT_LANGUAGE = 'en'
  DEFAULT_COUNTRY= 'IN'
  DEFAULT_CURRENCY = 'ET2'

  LANGUAGE_OPTIONS = {
    en: {
      en: 'English',
      ar: 'Arabic',
      ku: 'Kurdish',
      tr: 'Turkish'
    },
    ku: {
      en: 'ئینگلیزی',
      ar: 'عەرەبی',
      ku: 'کوردی',
      tr: 'تورکی'
    },
    ar: {
      en: 'الإنجليزية',
      ar: 'العربية',
      ku: 'الكردية',
      tr: 'التركية'
    },
    tr: {
      en: 'ingilizce',
      ar: 'Arapça',
      ku: 'Kürt',
      tr: 'Türk'
    }
  }

  BANK_LIST = {
      1 => { en: "IBK BANK", ko: "기업은행"},
      2 => { en: "FOSS KOREA", ko: "한국포스증권"},
      3 => { en: "KB BANK", ko: "국민은행"},
      4 => { en: "woori bank", ko: "우리은행"},
      5 => { en: "Shin Han bank", ko: "신한은행"},
      6 => { en: "HANA BANK", ko: "하나은행"},
      7 => { en: "NH BANK", ko: "농협"},
      8 => { en: "NH Chookhyup bank", ko: "축협"},
      9 => { en: "Su yup BANK", ko: "수협"},
      10 => { en: "Openbank", ko: "신협 "},
      11 => { en: "Standard Chartered bank", ko: "SC제일은행"},
      12 => { en: "K BANK", ko: "케이뱅크"},
      13 => { en: "KAKAO BANK", ko: "카카오뱅크"},
      14 => { en: "CITY BANK", ko: "한국씨티은행"},
      15 => { en: "Epost Bank", ko: "우체국"},
      16 => { en: "KN BANK", ko: "경남은행"},
      17 => { en: "KJ BANK", ko: "광주은행"},
      18 => { en: "DGB BANK", ko: "대구은행"},
      19 => { en: "Deutche Bank", ko: "도이치뱅크"},
      20 => { en: "Busan BANK", ko: "부산은행"},
      21 => { en: "NFCF BANK", ko: "산림조합"},
      22 => { en: "KDB BANK", ko: "산업은행"},
      23 => { en: "FSB BANK", ko: "저축은행"},
      24 => { en: "KFCC BANK", ko: "새마을금고"},
      25 => { en: "JB BANK", ko: "전북은행"},
      26 => { en: "JEJU BANK", ko: "제주은행"},
      27 => { en: "BNP PARIBA BANK", ko: "비앤비파리바은행"},
      28 => { en: "HSBC", ko: "HSBC"},
      29 => { en: "JP MORGAN", ko: "JP모간"},
      30 => { en: "IPROVEST", ko: "교보증권"},
      31 => { en: "DAISHIN BANK", ko: "대신증권"},
      32 => { en: "MIRAE ASSET", ko: "미래에셋"},
      33 => { en: "DB-FI", ko: "DB금융투자 "},
      34 => { en: "YUANTA BANK", ko: "유안타증권"},
      35 => { en: "MERITZ BANK", ko: "메리츠증권"},
      36 => { en: "BOOKOOK BANK", ko: "부국증권"},
      37 => { en: "SAMSUNG BANK", ko: "삼성증권"},
      38 => { en: "SOLOMON-FI", ko: "솔로몬투자증권"},
      39 => { en: "SHINYOUNG BANK", ko: "신영증권"},
      40 => { en: "SHINHAN INVEST", ko: "신한금융투자"},
      41 => { en: "NHQV", ko: "NH투자증권"},
      42 => { en: "EUGENEFN", ko: "유진투자증권"},
      43 => { en: "E-best", ko: "이베스트증권"},
      44 => { en: "KI-WOOM", ko: "키움증권"},
      45 => { en: "KBSEC", ko: "KB투자증권"},
      46 => { en: "HANA W", ko: "하나금융투자"},
      47 => { en: "TRUE FRIEND", ko: "한국투자증권"},
      48 => { en: "HANWHA-WM", ko: "한화증권"},
      49 => { en: "CAPE-FN", ko: "케이프투자증권"},
      50 => { en: "DIRECT-SKS", ko: "SK증권"},
      51 => { en: "ICBC BANK", ko: "중국공상은행"},
      52 => { en: "KAKAO PAYSEC", ko: "카카오페이증권"},
      53 => { en: "BNK-FN", ko: "BNK투자증권"}
    }
  TRANSLATED_MODELS =  %w[Sport Market Match Tournament Country Team Category].freeze
  FIREBASE_KEY_FILE_PATH = (JSON.parse(ENV['FIREBASE_KEY_FILE_PATH']) rescue ENV['FIREBASE_KEY_FILE_PATH']).freeze
end
