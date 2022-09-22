module Qtech
  class UpdateRecord < ApplicationInteraction
    object :q_tech_free_round

    def execute
      bonus_id, player_id = q_tech_free_round.bonus_id, q_tech_free_round.user_id
      data = client.round_promotion(bonus_id, player_id)
      update_records(data) unless data.nil?

    rescue ::StandardError => e
      custom_error_logger(e)
    end

    def update_records(data)
      assign_attributes(data)
      q_tech_free_round.save
    end

    def assign_attributes(data)
      q_tech_free_round.assign_attributes(bonus_id: data[:bonusId], total_bet_value: data[:totalBetValue],
                                          round_options: data[:roundOptions], status: data[:status].downcase, promoted_date_time: data[:promotedDateTime],
                                          total_payout: data[:totalPayout], promo_code: data[:promoCode], validity_days: data[:validityDays],
                                          rejectable: data[:rejectable], claimed_date_time: data[:claimedDateTime], failed_date_time: data[:failedDateTime],
                                          completed_date_time: data[:completedDateTime], cancelled_date_time: data[:cancelledDateTime],
                                          deleted_date_time: data[:deletedDateTime], expired_date_time: data[:expiredDateTime], claimed_round_option: data[:claimedRoundOption])
    end

    private

    def client
      @client ||= Qtech::ApiClient::Client.new
    end

    def custom_error_logger(exception)
      Honeybadger.notify(
        "[Process Create Games] : [#{exception.class}] : [#{exception.cause}]",
        class_name: exception.class
      )
    end

  end
end
