module LS
  class SportsMapper < ApplicationService

    def initialize(id, name)
      @id = id.to_s
      @name = name
    end

    def call
      esports? ? mapping_id : id
    end

    private

    attr_reader :id, :name

    def esports?
      Sport::ESPORTS_ID == id
    end

    def mapping_id
      id + mapping_code
    end

    def mapping_code
      Sport::MATCHERS.each do |_, rule|
        rule_matchers = rule[:matchers]
        key = rule[:key]
        found = rule_matchers.any? { |matcher| name.include?(matcher) }
        return key if found
      end
      ''
    end
  end
end
