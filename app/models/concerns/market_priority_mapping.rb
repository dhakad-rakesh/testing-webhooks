module MarketPriorityMapping
  extend ActiveSupport::Concern
  
  PRIORITY_CONST = [
    HIGH_PRIORITY = 0,
    DEFAULT_PRIORITY = 1,
    LOW_PRIORITY = 2
  ].freeze

  PRIORITIES_MAP = [
    { pattern: /^1X2$/, priority: HIGH_PRIORITY }
  ].freeze

  PRIORITIES = { 'high' => HIGH_PRIORITY,
                 'default' => DEFAULT_PRIORITY,
                 'low' => LOW_PRIORITY }.freeze
end
