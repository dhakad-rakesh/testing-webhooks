module Webhooks
  module Lsports
    class InplayController < ApplicationController
      skip_before_action :verify_authenticity_token

      def settlement
        payload = params.permit![:payload].to_h.with_indifferent_access
        Rails.logger.info "inplay settlement log"
        Rails.logger.info payload
        LS::FeedResultJob.perform_later(payload, 'listener_settlement') if payload[:Header].present? && payload[:Header][:Type] == 35
      end
    end
  end
end