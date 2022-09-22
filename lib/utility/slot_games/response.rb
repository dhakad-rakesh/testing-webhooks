module Utility
  module SlotGames
    module Response
      def authenticate_response
        user_balance_response.merge!(
          user: {
            id: @user.id.to_s,
            currency: Constants::CURRENCY
          }
        )
      end

      def user_balance_response
        {
          status: 0,
          funds: {
            balance: @user.available_amount.round(8),
            bonus: 0
          }
        }
      end

      # Message that doesn't block game play
      def non_intrusive_message(msg)
        {
          message: {
          type: 1,
          text: msg
        }
        }
      end 

      def token_not_found_response
        { status: 1 }
      end

      def session_not_found_response
        { status: 1 }
      end

      def session_expired_response
        { status: 2 }
      end

      def invalid_parameter_response
        { status: 422 }
      end

      def bet_not_found_response
        { status: 404 }
      end

      def repeated_bet_response
        { status: 1062 }
      end

      def bet_already_exist_response
        { status: 1062 }
      end

      def insufficient_funds_response
        { status: 8 }
      end

      def transaction_not_found_response
        { status: 422}
      end

      def success_response
        { status: 0 }
      end

      def general_error_response(error_message = '')
        { status: 500}
      end
    end
  end
end
