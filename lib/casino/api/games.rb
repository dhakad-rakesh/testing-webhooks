module Casino
  module Api
    module Games
      #without lobby
      def without_lobby(params: {})
        params['page'].present? ? get(url: "games?page=#{params['page']}", params: params) : get(url: "games")
      end

      #with lobby
      def with_lobby(params: {})
        get(url: "games/lobby?#{build_query_from_hash(params)}", params: params)
      end

      # Init Demo
      def init_demo(params)
        post("games/init-demo", params)
      end

      def init(params)
        post("games/init", params)
      end

      def self_validation(params)
        post("self-validate", params)
      end
    end
  end
end
