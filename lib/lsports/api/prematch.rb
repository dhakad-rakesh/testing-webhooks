module Api
  module Prematch
    def sports
      get_prematch("/GetSports")
    end

    def fixtures
      get_prematch("/GetFixtures")
    end

    def fixture_markets
      get_prematch("/GetFixtureMarkets")
    end

    def events
      get_prematch("/GetEvents")
    end

    def markets
      get_prematch("/GetMarkets")
    end

    def locations
      get_prematch("/GetLocations")
    end

    def scores
      get_prematch("/GetScores")
    end

    def snapshot
      get_inplay("/Snapshot/GetSnapshotJson")
    end

    def ordered_inplay_fixture
      get_inplay("/schedule/GetOrderedFixtures")
    end
  end
end
