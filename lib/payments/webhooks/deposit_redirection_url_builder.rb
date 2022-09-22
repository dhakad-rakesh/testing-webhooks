# frozen_string_literal: true

module Payments
  module Webhooks
    class DepositRedirectionUrlBuilder < ApplicationService
      include Rails.application.helpers

      STATES_MAP = {
        ::Payments::Webhooks::Statuses::SUCCESS => :success,
        ::Payments::Webhooks::Statuses::CANCELLED => :error,
        ::Payments::Webhooks::Statuses::FAILED => :fail,
        ::Payments::Webhooks::Statuses::SYSTEM_ERROR => :fail,
        ::Payments::Webhooks::Statuses::FALLBACK_REDIRECTION => :fallback_redirection
      }.freeze

      def initialize(status:, request_id:, custom_message: nil)
        @status = status
        @request_id = request_id
        @custom_message = custom_message
      end

      def call
        dynamic_url(redirection_to)
      end

      private

      attr_reader :status, :request_id, :custom_message

      # TODO: Update for web version
      def redirection_to
        URI("#{ENV['DOMAIN_URL']}/deposits/?#{query_params}").to_s
      end

      def query_params
        URI.encode_www_form(
          depositState: state,
          depositStateMessage: custom_message || general_message,
          depositDetails: base_64_deposit_summary
        )
      end

      def state
        STATES_MAP[status]
      end

      def general_message
        case status
        when ::Payments::Webhooks::Statuses::SUCCESS
          I18n.t('messages.deposit.success')
        when ::Payments::Webhooks::Statuses::CANCELLED
          I18n.t('errors.messages.deposit.cancelled')
        when ::Payments::Webhooks::Statuses::FAILED
          I18n.t('errors.messages.deposit.failed')
        when ::Payments::Webhooks::Statuses::SYSTEM_ERROR
          I18n.t('errors.messages.technical_error_happened')
        end
      end

      def base_64_deposit_summary
        Base64.encode64(URI.encode_www_form(deposit_summary))
      end

      def deposit_summary
        return {} unless ledger

        {
          amount: ledger.amount,
          paymentMethod: ledger.mode
        }
      end

      def ledger
        @ledger ||= Ledger.find_by(id: request_id)
      end
    end
  end
end
