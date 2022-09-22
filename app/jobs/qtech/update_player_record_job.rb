module Qtech
  class UpdatePlayerRecordJob < ApplicationJob
    queue_as :default

    def perform(round)
      Qtech::UpdateRecord.run!(q_tech_free_round: round)
    end
  end
end
