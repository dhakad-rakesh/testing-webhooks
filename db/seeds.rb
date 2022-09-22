#==================LSPORTS DATA SETUPS=========================

# Setup Gammabet Settings
setting = GammabetSetting.find_or_initialize_by(setting_of: :application)
setting.save
GammabetSetting.allow_betting

# Create Super Admin
admin = AdminUser.find_or_create_by(email: 'admin@yopmail.com')
admin.password = 'Betdefi@123'
admin.add_role :super_admin
admin.save

# Create locations/countries
# Rake::Task['locations:create'].invoke

# Create sports
# Rake::Task['sports:create'].invoke

# Generate sport translations
# Rake::Task['sports:generate_translations'].invoke

# Seed Categories
require Rails.root.join('db/seeds/categories')

# TODO: Use similar design everywhere
# Create market categories
# Rake::Task['categories:create'].invoke

# Generate category translations
Rake::Task['categories:generate_translations'].invoke

# Create markets
# Rake::Task['markets:create'].invoke

# Create notification types
Rake::Task['notification_types:create'].invoke

# Initialize custom settings
Rake::Task['settings:create'].invoke

# Seed languages
[
  {
    name: 'English',
    enabled: true,
    symbol: 'en',
    is_default: true
  },
  {
    name: 'Kurdish',
    enabled: true,
    symbol: 'ku',
    is_default: false
  },
  {
    name: 'Arabic',
    enabled: true,
    symbol: 'ar',
    is_default: false
  },
  {
    name: 'Turkish',
    enabled: true,
    symbol: 'tr',
    is_default: false
  }
].each { |lang| Language.find_or_create_by(lang) }

# Setup Supported Sports
# SUPPORTED_SPORTS = [{ "Id": 6046, "Name": 'Football', "Rank": 1 },
#                     { "Id": 48242, "Name": 'Basketball', "Rank": 2 },
#                     { "Id": 154830, "Name": 'Volleyball', "Rank": 3 },
#                     { "Id": 35232, "Name": 'Ice Hockey', "Rank": 4 },
#                     { "Id": 54094, "Name": 'Tennis', "Rank": 5 },
#                     { "Id": 35709, "Name": 'Handball', "Rank": 6 }].freeze

# SUPPORTED_SPORTS.each do |hash|
#   sport = Sport.find_or_initialize_by(uid: hash[:Id])

#   sport.name = hash[:Name]
#   sport.enabled = true
#   sport.status = 'active'
#   sport.rank = hash[:Rank]
#   sport.save! if sport.changed?
# end

puts 'Done..!!'

# market_outcomes = [
#   {sport: 'Football', market_name: "Double Chance", uid: 7, is_specifier_market: false,
#     outcome_names: [{id: 4923517725274899, name: 'Draw'},
#       {id: 4184464145274899, name: 'Home'},
#       {id: 4923536675274899, name: 'Away'}],
#     play_type_name: 'win', bet_type_name: "3 way"
#   },
#  {sport: 'Football', market_name: "Correct Score", uid: 6, is_specifier_market: false,
#     outcome_names: [{id: 16497524395275740, name: "0-4"},
#       {id: 16497525365275740, name: "1-4"},
#       {id: 16497523735275740, name: "2-4"},
#       {id: 16497524435275740, name: "0-0"},
#       {id: 16497524765275740, name: "3-2"},
#       {id: 16497523775275740, name: "2-0"},
#       {id: 16497524745275740, name: "3-0"},
#       {id: 16497523125275740, name: "4-1"},
#       {id: 16497525395275740, name: "1-1"},
#       {id: 16497524375275740, name: "0-6"},
#       {id: 16497524755275740, name: "3-3"},
#       {id: 16497523785275740, name: "2-1"},
#       {id: 16497524735275740, name: "3-1"},
#       {id: 16497524415275740, name: "0-2"},
#       {id: 16497523795275740, name: "2-2"},
#       {id: 16497524425275740, name: "0-3"},
#       {id: 16497525385275740, name: "1-2"},
#       {id: 16497525405275740, name: "1-0"},
#       {id: 16497524405275740, name: "0-5"},
#       {id: 16497525375275740, name: "1-3"},
#       {id: 16497523115275740, name: "4-0"},
#       {id: 16497523805275740, name: "2-3"},
#       {id: 16497525355275740, name: "1-5"}],
#     play_type_name: "score",  bet_type_name: "correct"
#   },
#   {sport: 'Football',
#     market_name: "Asian Handicap", uid: 3, is_specifier_market: true,
#     outcome_names: [{id: 10765351045275741, name: "away"},
#       {id: 14365676125275741, name: "home"},
#       {id: 635754975275741, name: "away"},
#       {id: 9764177795275741, name: "home"}],
#     play_type_name: "win",  bet_type_name: "handicap"
#   },
#   {sport: 'Basketball',
#     market_name: "Asian Handicap Including Overtime", uid: 342, is_specifier_market: false,
#     outcome_names: [{id: 13193936145273309, name: "home"}, {id: 16207970285273309, name: "away"}], play_type_name: "win",  bet_type_name: "handicap"
#  }
# ]

# market_outcomes.each do |market_option|
#   play_type = PlayType.find_or_create_by(name: market_option[:play_type_name].downcase)
#   bet_type = BetType.find_or_create_by(name: market_option[:bet_type_name].downcase)
#   sport = Sport.find_by_name market_option[:sport]
#   market = Market.find_or_create_by(name: market_option[:market_name], uid: market_option[:uid], is_specifier_market: market_option[:is_specifier_market], play_type_id: play_type.id, bet_type_id: bet_type.id, sport_id: sport.id)
#   market_option[:outcome_names].each do |outcome_row|
#     outcome = Outcome.find_or_create_by(uid: outcome_row[:id]) do |o|
#       o.name = outcome_row[:name]
#     end
#     market.outcomes << outcome
#   end
# end
#==================END LSPORTS DATA SETUPS=========================

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# setting = GammabetSetting.find_or_initialize_by(setting_of: :application)
# setting.save
# GammabetSetting.allow_betting

# Language.create([{ name: 'English' }, { name: 'Hindi' }, { name: 'Chinese' }, { name: 'Portuguese' },
#                  { name: 'Spanish' }, { name: 'Arabic' }])
# Dialect.create([{ name: 'American English' }, { name: 'British English' }, { name: 'Min' }, { name: 'Hakka' }])
# Occupation.create([{ name: 'Manager' }, { name: 'Doctor' }, { name: 'Engineer' }, { name: 'Self Employed' },
#                    { name: 'Student' }])
# Topic.create([{ name: 'Cristiano Ronaldo' }, { name: 'Lionel Messi' }, { name: 'Kylian Mbappe' },
#               { name: 'FC Barcelona' }, { name: 'Real Madrid' }, { name: 'Eden Hazard' }, { name: 'Arsenal' },
#               { name: 'Premier League' }, { name: 'Messi is better than Ronaldo' }])

# SecurityQuestion.find_or_create_by(question: 'What is your fathers birth place?')

# admin = AdminUser.find_or_create_by(email: 'admin@yopmail.com')
# admin.password = 'Bwinner@2019'
# admin.add_role :super_admin
# admin.save

# sports.each_with_index do |sport, index|
#   Sport.create(name: sport, uid: index+1,
#                enabled: false, status: "active")
# end

# #Enable Soccer sport
# sport = Sport.find_by(name: 'Soccer')
# sport.update_column(:enabled, true)

# market_outcomes = [{sport: 'Soccer', market_name: "Match Winner", uid: 1, is_specifier_market: false, outcome_names: ['Draw', 'Home', 'Away'], play_type_name: 'win', bet_type_name: "3 way" },
#   {sport: 'Soccer', market_name: "Double Chance", uid: 222, is_specifier_market: false, outcome_names: ['Draw', 'Home', 'Away'], play_type_name: "win", bet_type_name: "double chance"},
#   {sport: 'Soccer', market_name: "Correct Score", uid: 81, is_specifier_market: false, outcome_names: ["2:0","2:1","3:0","3:1","3:2","4:0","4:1","4:2","4:3","5:0","5:1","5:2","6:0","6:1","6:2","0:0","1:1","2:2","3:3","0:1","0:2","0:3","1:2","1:3","2:3","7:0","7:1","7:2","8:0","8:1","9:0"], play_type_name: "score", bet_type_name: "correct" },
#   {sport: 'Soccer', market_name: "Asian Handicap", uid: 4, is_specifier_market: true, outcome_names: ['Home', 'Away'], play_type_name: 'win', bet_type_name: 'handicap' },
#   {sport: 'Soccer', market_name: "HT/FT Double", uid: 12, is_specifier_market: false, outcome_names: ["Draw/Draw", "Home/Home", "Away/Away", "Draw/Home", "Draw/Away", "Home/Draw", "Home/Away", "Away/Draw", "Away/Home"], play_type_name: "win", bet_type_name: "3 way" },
#   {sport: 'Soccer', market_name: "Both Teams To Score", uid: 15, is_specifier_market: false, outcome_names: ['Yes', 'No'], play_type_name: "score", bet_type_name: "yes/no" },
#   {sport: 'Soccer', market_name: "Handicap Result", uid: 79, is_specifier_market: true, outcome_names: ['Draw', 'Home', 'Away'], play_type_name: "win", bet_type_name: "handicap" },
#   {sport: 'Soccer', market_name: "Highest Scoring Half", uid: 91, is_specifier_market: false, outcome_names: ['Draw', '1st Half', '2nd Half'], play_type_name: "high score", bet_type_name: 'draw/1st half/2nd half' },
#   {sport: 'Soccer', market_name: "Handicap Result 1st Half", uid: 22600, is_specifier_market: true, outcome_names: ['Draw', 'Home', 'Away'], play_type_name: "win", bet_type_name: "handicap" },
#   {sport: 'Soccer', market_name: "Asian Handicap First Half", uid: 22601, is_specifier_market: true, outcome_names: ['Home', 'Away'], play_type_name: 'win', bet_type_name: 'handicap' },
#   {sport: 'Soccer', market_name: "Double Chance - 1st Half", uid: 22602, is_specifier_market: false, outcome_names: ['Draw', 'Home', 'Away'], play_type_name: "win", bet_type_name: "double chance" },
#   {sport: 'Soccer', market_name: "Both Teams To Score - 1st Half", uid: 22604, is_specifier_market: false, outcome_names: ['Yes', 'No'], play_type_name: "score", bet_type_name: "yes/no" },
#   {sport: 'Soccer', market_name: "Both Teams To Score - 2nd Half", uid: 22605, is_specifier_market: false, outcome_names: ['Yes', 'No'], play_type_name: "score", bet_type_name: "yes/no" },
#   {sport: 'Soccer', market_name: "Goals Odd Even", uid: 1, is_specifier_market: false, outcome_names: ['Odd', 'Even'], play_type_name: "goals", bet_type_name: "odd/even" },
#   {sport: 'Soccer', market_name: "Home Team Odd Even Goals", uid: 1, is_specifier_market: false, outcome_names: ['Odd', 'Even'], play_type_name: "goals", bet_type_name: "odd/even" },
#   {sport: 'Soccer', market_name: "Away Team Odd Even Goals", uid: 1, is_specifier_market: false, outcome_names: ['Odd', 'Even'], play_type_name: "goals", bet_type_name: "odd/even" },
#   {sport: 'Soccer', market_name: "Half Time Result", uid: 1, is_specifier_market: false, outcome_names: ['Draw', 'Home', 'Away'], play_type_name: "win", bet_type_name: "3 way" },
#   {sport: 'Soccer', market_name: "Half Time Double Chance", uid: 1, is_specifier_market: false, outcome_names: ['Draw', 'Home', 'Away'], play_type_name: "win", bet_type_name: "double chance" },
#   {sport: 'Soccer', market_name: "Half Time Correct Score", uid: 1, is_specifier_market: false, outcome_names: ["2:0","2:1","3:0","3:1","3:2","4:0","4:1","4:2","4:3","5:0","5:1","5:2","6:0","6:1","6:2","0:0","1:1","2:2","3:3","0:1","0:2","0:3","1:2","1:3","2:3","7:0","7:1","7:2","8:0","8:1","9:0"], play_type_name: "score" , bet_type_name: "correct" },
#   {sport: 'Soccer', market_name: "1st Half Goals Odd Even", uid: 1, is_specifier_market: false, outcome_names: ['Odd', 'Even'], play_type_name: "goals", bet_type_name: "odd/even" },
#   {sport: 'Soccer', market_name: "Home Team Highest Scoring Half", uid: 1, is_specifier_market: false, outcome_names: ['Draw', '1st Half', '2nd Half'], play_type_name: "high score", bet_type_name: 'draw/1st half/2nd half' },
#   {sport: 'Soccer', market_name: "Away Team Highest Scoring Half", uid: 1, is_specifier_market: false, outcome_names: ['Draw', '1st Half', '2nd Half'], play_type_name: "high score", bet_type_name: 'Draw/1st Half/2nd Half' },
#   {sport: 'Soccer', market_name: "2nd Half Goals Odd Even", uid: 1, is_specifier_market: false, outcome_names: ['Odd', 'Even'], play_type_name: "goals", bet_type_name: "odd/even" },
#   {sport: 'Soccer', market_name: "Match Goals", uid: 1, is_specifier_market: true, outcome_names: ['Over', 'Under'], play_type_name: "goals", bet_type_name: "over/under" },
#   {sport: 'Soccer', market_name: "First Half Goals", uid: 1, is_specifier_market: true, outcome_names: ['Over', 'Under'], play_type_name: "goals", bet_type_name: "over/under" },
#   {sport: 'Soccer', market_name: "Total Corners", uid: 1, is_specifier_market: true, outcome_names: ['Yes', 'No'], play_type_name: "corners", bet_type_name: "yes/no" },
#   {sport: 'Soccer', market_name: "2-Way Corners", uid: 1, is_specifier_market: true, outcome_names: ['Over', 'Under'], play_type_name: "corners", bet_type_name: "over/under" },
#   {sport: 'Soccer', market_name: "1st Half Corners", uid: 1, is_specifier_market: true, outcome_names: ['Exact', 'Over', 'Under'], play_type_name: "corners", bet_type_name: "exact/over/under" },
#   {sport: 'Soccer', market_name: "Alternative Total Corners", uid: 1, is_specifier_market: true, outcome_names: ['Exact', 'Over', 'Under'], play_type_name: "corners", bet_type_name: "exact/over/under" },
#   {sport: 'Soccer', market_name: "Asian Corners", uid: 1, is_specifier_market: true, outcome_names: ['Over', 'Under'], play_type_name: "corners", bet_type_name: "over/under" },
#   {sport: 'Soccer', market_name: "1st Half Asian Corners", uid: 1, is_specifier_market: true, outcome_names: ['Over', 'Under'], play_type_name: "corners", bet_type_name: "over/under" },
#   {sport: 'Soccer', market_name: "Both Teams to Score in 1st Half", uid: 1, is_specifier_market: false, outcome_names: ['Yes', 'No'], play_type_name: "score", bet_type_name: "yes/no" },
#   {sport: 'Soccer', market_name: "Both Teams to Score in 2nd Half", uid: 1, is_specifier_market: false, outcome_names: ['Yes', 'No'], play_type_name: "score", bet_type_name: "yes/no" },
#   {sport: 'Soccer', market_name: "3Way Result", uid: 1, is_specifier_market: false, outcome_names: ['X', '1', '2'], play_type_name: 'win', bet_type_name: "3 way" },
#   {sport: 'Soccer', market_name: "Home/Away", uid: 2, is_specifier_market: false, outcome_names: ['1', '2'], play_type_name: 'win', bet_type_name: "1/2" }
# ]

# #new markets for phase-2
# [{sport: 'Soccer', market_name: "Draw No Bet", uid: "6", is_specifier_market: nil, outcome_names: ["1", "2"]},
#  {sport: 'Soccer', market_name: "Draw No Bet", uid: "10563", is_specifier_market: nil, outcome_names: ["Home", "Away"]},
#  {sport: 'Soccer', market_name: "Both Teams To Score", uid: "7", is_specifier_market: nil, outcome_names: ["Yes", "No"]},
#  {sport: 'Soccer', market_name: "Both Teams To Score", uid: "10565", is_specifier_market: nil, outcome_names: ["Yes", "No"]},
#  {sport: 'Soccer', market_name: "Result Both Teams To Score", uid: "8", is_specifier_market: nil, outcome_names: ["Home Yes", "Away Yes", "Draw Yes", "Home No", "Away No", "Draw No"]},
#  {sport: 'Soccer', market_name: "Result / Both Teams To Score", uid: "50461", is_specifier_market: nil, outcome_names: ["Home & Yes", "Away & Yes", "X & Yes", "Home & No", "Away & No", "X & No"]}
# ]

# market_outcomes.each do |market_option|
#   play_type = PlayType.find_or_create_by(name: market_option[:play_type_name].downcase)
#   bet_type = BetType.find_or_create_by(name: market_option[:bet_type_name].downcase)
#   sport = Sport.find_by_name market_option[:sport]
#   market = Market.find_or_create_by(name: market_option[:market_name], uid: market_option[:uid], is_specifier_market: market_option[:is_specifier_market], play_type_id: play_type.id, bet_type_id: bet_type.id, sport_id: sport.id)
#   market_option[:outcome_names].each do |outcome_name|
#     outcome = Outcome.find_or_create_by(name: outcome_name)
#     market.outcomes << outcome
#   end
# end
