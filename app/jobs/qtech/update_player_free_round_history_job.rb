module Qtech
  class UpdatePlayerFreeRoundHistoryJob < ApplicationJob
    queue_as :default

    def perform
      all_free_rounds_data = QTechFreeRound.promoted_or_inprogress.order_by_recent
      Qtech::UpdatePlayerRecords.run!(rounds: all_free_rounds_data)
    end
  end
end
