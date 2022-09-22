module BR
  module AMQP
    class OddsSummaryJob < ApplicationJob
      queue_as :odds_summary_job

      def perform(xml_data, routing_key)
        @json_data = xml_data.xml_to_hash[:odds_change]
        @match = routing_key.include?('match') &&
                 Match.find_by(uid: @json_data[:event_id])
        return if @match.blank? || @match.non_supported_tournament?
        old_data = firebase_client.get("odds_summary/#{@match.uid}/markets").body || {}
        # Need to merge old and new hashes with n level of nesting.
        update_on_firebase(old_data.deep_merge(generate_market_data))
      end

      private

      def generate_market_data
        content = {}
        @all_markets_data = @json_data.dig(:odds, :market)
        Array.wrap(@all_markets_data).each do |market_data|
          specifier_text = market_data[:specifiers].presence || '1'
          specifier_id_content = specifier_key(specifier_text)
          # Every key in firebase should start with character because
          # number can be treated as array in firebase.
          # https://stackoverflow.com/a/17777278/3759158
          content["market_#{market_data[:id]}"] = {
            'specifiers' => {
              "specifier_#{specifier_id_content}" => process_outcomes(market_data)
            }
          }
        end
        content
      end

      def process_outcomes(market_data)
        outcome_data = {}
        Array.wrap(market_data['outcome']).each do |outcome|
          # https://stackoverflow.com/a/17777278/3759158
          outcome_data["outcome_#{outcome[:id]}"] = {
            'timestamps' => {
              "timestamp_#{@json_data[:timestamp]}" => outcome_params(outcome, market_data[:specifiers])
            }
          }
        end
        outcome_data
      end

      # Convert specifier text to a unique key by concatenating all ascii values of characters in specifier text
      def specifier_key(specifier_text)
        specifier_text.split('').map(&:ord).join('')
      end

      def outcome_params(outcome, specifiers)
        { 'odds' => outcome[:odds], 'probabilities' => outcome[:probabilities],
          'status' => outcome[:active], 'specifiers' => specifier_data(specifiers).to_h }
      end

      def specifier_data(specifiers)
        @specifier_text = specifiers.present? ? specifiers.split('|').map { |a| a.split('=') } : nil
      end

      def log_type
        @log_type ||= @routing_key.split('.').slice(1, 2).join('.')
      end

      def firebase_client
        # @firebase_client ||= #Firebase::Client.new(Figaro.env.firebase_base_url)
      end

      def update_on_firebase(data)
        firebase_client.update("odds_summary/#{@match.uid}/markets", data)
      end
    end
  end
end
