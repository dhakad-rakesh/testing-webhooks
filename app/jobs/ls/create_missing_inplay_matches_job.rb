module LS
  class CreateMissingMatchesJob < ApplicationJob
    queue_as :default

    def perform(missing_matches_list)
      @missing_matches_list = missing_matches_list
      return if missing_matches_list.blank?
      data = client.fixtures
      create_matches(data)
    end

    private

    def create_matches(data)
      data[:Body].each do |fixture_data|
        fixture_id = fixture_data[:FixtureId]
        fixture = fixture_data[:Fixture]
        LS::CreateMatchJob.perform_later(fixture_id, fixture)
      end
    end

    def client
      @client ||= Lsports::Client.new(params: params)
    end

    def params
      { fixtures: @missing_matches_list.join(", ") }
    end
  end
end