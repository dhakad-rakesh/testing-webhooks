module Qtech
  class RequestBuilder
    attr_accessor :game, :current_user, :ip, :language

    def initialize(current_user, ip, game, lang)
      @ip = ip
      @current_user = current_user
      @game = game
      @language = lang
    end

    def execute
      {
        playerId: current_user.id.to_s,
        displayName: "manish",
        currency: 'INR',
        country: 'IN',
        gender: current_user.try(:gender) || 'M',
        birthDate: (current_user&.date_of_birth&.strftime("%Y-%m-%d") rescue nil) || '1990-01-01',
        lang: @language,
        mode: 'demo',
        device: 'desktop',
        returnUrl: Figaro.env.application_url || 'https://admin.mellocasino.com/',
        walletSessionId: wallet_session_id
      }
    end

    def wallet_session_id
      Rails.cache.fetch("qtech_casino_session_#{current_user&.id}", expire_in: 5.hour.from_now) do
        current_user.generate_access_token&.token
      end
    end
  end
end
