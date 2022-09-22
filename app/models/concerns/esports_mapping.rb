# frozen_string_literal: true

module EsportsMapping
  extend ActiveSupport::Concern

  ESPORTS_ID = '687890'.freeze

  CALL_OF_DUTY = 'Call of Duty'
  CS_GO = 'CS:GO'
  COUNTER_STRIKE = 'Counter-Strike'
  DOTA_2 = 'Dota 2'
  KING_OF_GLORY = 'King Of Glory'
  LEAGUE_OF_LEGENDS = 'League of Legends'
  OVERWATCH = 'Overwatch'
  RAINBOW_SIX = 'Rainbow Six'
  ROCKET_LEAGUE = 'Rocket League'
  STARCRAFT_II = 'StarCraft II'
  STARCRAFT_2 = 'StartCraft2'
  STREET_FIGHTER_V = 'Street Fighter V'
  WARCRAFT_III = 'Warcraft III'
  WARCRAFT_3 = 'Warcraft3'

  SUPPORTED_ESPORTS_MAP = {
    CALL_OF_DUTY => '01',
    CS_GO => '02',
    DOTA_2 => '03',
    KING_OF_GLORY => '04',
    LEAGUE_OF_LEGENDS => '05',
    OVERWATCH => '06',
    RAINBOW_SIX => '07',
    ROCKET_LEAGUE => '08',
    STARCRAFT_II => '09',
    STREET_FIGHTER_V => '10',
    WARCRAFT_III => '11',
  }.freeze

  # TODO: Update translations
  ESPORTS_NAMES_MAP = {
    '01' => {
      :ar => CALL_OF_DUTY
    },
    '02' => {
      :ar => CS_GO
    },
    '03' => {
      :ar => DOTA_2
    },
    '04' => {
      :ar => KING_OF_GLORY
    },
    '05' => {
      :ar => LEAGUE_OF_LEGENDS
    },
    '06' => {
      :ar => OVERWATCH
    },
    '07' => {
      :ar => RAINBOW_SIX
    },
    '08' => {
      :ar => ROCKET_LEAGUE
    },
    '09' => {
      :ar => STARCRAFT_II
    },
    '10' => {
      :ar => STREET_FIGHTER_V
    },
    '11' => {
      :ar => WARCRAFT_III
    }
  }.freeze

  MATCHERS = {
    call_of_duty: {
      matchers: [CALL_OF_DUTY],
      key: SUPPORTED_ESPORTS_MAP[CALL_OF_DUTY]
    },
    cs_go: {
      matchers: [CS_GO, COUNTER_STRIKE],
      key: SUPPORTED_ESPORTS_MAP[CS_GO]
    },
    dota_2: {
      matchers: [DOTA_2],
      key: SUPPORTED_ESPORTS_MAP[DOTA_2]
    },
    king_of_glory: {
      matchers: [KING_OF_GLORY],
      key: SUPPORTED_ESPORTS_MAP[KING_OF_GLORY]
    },
    league_of_legends: {
      matchers: [LEAGUE_OF_LEGENDS],
      key: SUPPORTED_ESPORTS_MAP[LEAGUE_OF_LEGENDS]
    },
    overwatch: {
      matchers: [OVERWATCH],
      key: SUPPORTED_ESPORTS_MAP[OVERWATCH]
    },
    rainbox_six: {
      matchers: [RAINBOW_SIX],
      key: SUPPORTED_ESPORTS_MAP[RAINBOW_SIX]
    },
    rocket_league: {
      matchers: [ROCKET_LEAGUE],
      key: SUPPORTED_ESPORTS_MAP[ROCKET_LEAGUE]
    },
    starcraft_2: {
      matchers: [STARCRAFT_II],
      key: SUPPORTED_ESPORTS_MAP[STARCRAFT_II]
    },
    street_fighter_5: {
      matchers: [STREET_FIGHTER_V],
      key: SUPPORTED_ESPORTS_MAP[STREET_FIGHTER_V]
    },
    warcraft_3: {
      matchers: [WARCRAFT_III, WARCRAFT_3],
      key: SUPPORTED_ESPORTS_MAP[WARCRAFT_III]
    }
  }.freeze
end
