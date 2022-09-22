module Utility
  module Casino
    module Response
      def user_balance_response
        {
          status: 'OK',
          balance: @user.et2_amount.round(2),
          bonus: 0,
          uuid: @uuid
        }
      end

      def token_not_found_response
        { status: 'INVALID_TOKEN_ID'}
      end

      def session_not_found_response
        { status: 'INVALID_SID'}
      end

      def invalid_parameter_response
        { status: 'INVALID_PARAMETER'}
      end

      def bet_not_found_response
        { status: 'BET_DOES_NOT_EXIST'}
      end

      def repeated_bet_response
        { status: 'BET_ALREADY_SETTLED'}
      end

      def bet_already_exist_response
        { status: 'BET_ALREADY_EXIST'}
      end

      def check_response
        { status: 'OK', uuid: @uuid, sid: @new_session_id}
      end

      def internal_error_response
        { "error_code": "INTERNAL_ERROR", "error_description": "This player do not exist OR other error." }
      end

      def insufficient_funds_response
        { status: 'INSUFFICIENT_FUNDS' }
      end

      def invalid_header_response
        { error_code: 'INVALID_HEADER', error_description: 'Header is not valid' }
      end

      def invalid_user_response
        { error_code: 'INVALID_USER', error_description: 'User not found in our DB' }
      end

      def invalid_request_response
        { error_code: 'INVALID_REQUEST', error_description: 'Request is not valid' }
      end

      def invalid_game_session_response
        { error_code: 'INVALID_GAME_SESSION', error_description: 'Game session not found in our DB' }
      end

      # def user_balance_response
      #   { balance: @user.available_amount, status: 200 }
      # end

      def funds_response(s_trnsaction)
        # Display 4 digits after decimal
        { balance: ('%.4f' % s_trnsaction.wallet_balance), transaction_id: s_trnsaction.transaction_id } 
      end

      def transaction_not_found_response
        { status: 'INVALID_PARAMETER'}
      end

      def invalid_params_error_response
        { status: 'INVALID_PARAMETER'}
      end

      def success_response
        { status: 'OK' }
      end

      def general_error_response(error_message = '')
        { status: 'TEMPORARY_ERROR'}
      end
    end
  end
end
