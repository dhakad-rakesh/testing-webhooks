module Casino
  module Api
    module Authentication
      @params = {}
      @request_headers = {}

      def headers(params)
        @params = params
        auth_headers.merge('X-Sign' => x_sign)
      end

      def x_sign_from_headers(params, request_headers)
        @params = params
        @request_headers = request_headers
        x_sign
      end

      def auth_headers
        if @request_headers.nil?
          @auth_headers ||= { 'X-Merchant-Id' => merchant_id,
                              'X-Timestamp' => Time.now.to_i,
                              'X-Nonce' => SecureRandom.hex }
        else
          @request_headers
        end
      end

      def x_sign
        hash_hmac(hash_string)
      end

      def request_params
        # • game_uuid: string, required , Game UUID provided in /games 
        # player_id: string , required , Unique player ID on the integrator side 
        # • player_name : string, required, Player nickname that will be shown in some games 
        # currency : string, required , Player currency that will be used in this game session 
        # • session_id string , required , Unique game session ID on the integrator side 
        # return_url: string, optional , Redirect player to this url after game ends 
        # • language : string, optional, Player language 
        # email: string, optional , Player email 
        # • lobby_data : string, optional , Used only for games with lobby. Provided in /lobby

        r_params = {}
        r_params.merge!(@params) if @params.present?
        r_params
      end

      # Need to merge requested params with auth headers while int user request
      def merged_params
        auth_headers.merge(request_params)
      end

      def sort_merged_params
        merged_params.sort.to_h
      end

      def hash_string
        hs = build_query_from_hash(sort_merged_params)
        Rails.logger.info(hs)
        hs
      end

      # Genrate hmac hash hash string
      def hash_hmac(data)
        digest = OpenSSL::Digest.new('sha1')
        OpenSSL::HMAC.hexdigest(digest, merchant_key , data)
      end

      def merchant_key
        @merchant_key ||= Figaro.env.casino_merchant_key
      end
    end
  end
end