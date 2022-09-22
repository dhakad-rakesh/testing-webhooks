module Translations
  class UpdateSchedule < ApplicationInteraction
    hash :data, strip: false
    symbol :locale

    set_callback :execute, :before, :match

    def execute
      return unless match
      Mobility.with_locale(locale) do
        ActiveRecord::Base.transaction do
          update_match!
          update_tournament!
          update_country!
          update_teams!
        end
      end
    end

  protected

    def match
      @match ||= ::Match.find_by(uid: data[:uid])
    end

    def update_match!
      match.update!(name: data[:name])    
    end

    def update_tournament!
      match.tournament.update!(name: data[:tournament_name])    
    end

    def update_country!
      match.tournament.country.update!(name: data[:country_name])
    end

    def update_teams!
      match.teams.each do |team|
        team.update!(name: data[:team_names][team.uid.to_s])
      end
    end
  end
end
