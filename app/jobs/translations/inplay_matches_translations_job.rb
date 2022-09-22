module Translations
  class InplayMatchesTranslationsJob < ApplicationJob
    queue_as :low

    FIRESTORE_COLL_NAME = 'l_event'
    TRANSLATIONS_LANG = [:cz, :ru]

    def perform

      coll_ref = firestore.col(FIRESTORE_COLL_NAME)
      firestore_records = coll_ref.where('translations', '=', false).select(:Fixture).get

      firestore.batch do |batch|
        firestore_records.each do |record|
          begin
            match_data = record.data
            data_to_merge = { 
                              Fixture: {
                                League: {},
                                Location: {},
                                Participants: match_data[:Fixture][:Participants],
                                Sport: {},
                              }, 
                              translations: true 
                            }

            # match = Match.find_by_uid(record.document_id)
            country = Country.find_by_uid(match_data[:Fixture][:Location][:Id])
            tournament = Tournament.get_by_uid_and_country_uid(match_data[:Fixture][:League][:Id], country.try(:uid))
            sport = Sport.find_by_uid(match_data[:Fixture][:Sport][:Id])
            TRANSLATIONS_LANG.each do |lang|
              data_to_merge[:Fixture][:League]["Name_#{lang}"] = get_translation_name(tournament, lang)
              data_to_merge[:Fixture][:Location]["Name_#{lang}"] = get_translation_name(country, lang)
              data_to_merge[:Fixture][:Sport]["Name_#{lang}"] = get_translation_name(sport, lang)
              data_to_merge[:Fixture][:Participants].each do |participant|
                team = Team.find_by_uid(participant[:Id])
                participant["Name_#{lang}"] = get_translation_name(team, lang)
              end
            end
            batch.set("#{FIRESTORE_COLL_NAME}/#{record.document_id}", data_to_merge, {merge: true})
          rescue ::StandardError => e
            Rails.logger.error "Error on updating translation of match #{record&.document_id}. #{e.message} "
          end
        end
      end
    end

    private

    def firestore
      @firestore ||= OddsStore::CloudFirestore.service
    end

    def get_translation_name(obj, lang)
      ( obj.name_backend.read(lang).present? ? obj.name_backend.read(lang) : obj.name ) rescue ""
    end
  end
end