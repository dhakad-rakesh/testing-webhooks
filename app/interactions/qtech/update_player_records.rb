module Qtech
  class UpdatePlayerRecords < ApplicationInteraction
    array :rounds

    def execute
      rounds.each do |round|
        Qtech::UpdatePlayerRecordJob.perform_later(round)
      end

    rescue ::StandardError => e
      custom_error_logger(e)
    end

    private

    def custom_error_logger(exception)
      Honeybadger.notify(
        "[Process Create Games] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class
      )
    end

  end
end
