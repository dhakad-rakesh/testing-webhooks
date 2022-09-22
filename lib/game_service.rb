class GameService
  KEY_NAME = :enabled_game_serice
  AVAILABLE_SPORT_APIS = %w(GS BR)

  class << self 
    def activate(value)
      if AVAILABLE_SPORT_APIS.include? value
        Rails.cache.write(KEY_NAME, value)
      end
    end

    def active
      Rails.cache.fetch(KEY_NAME) || Figaro.env.enabled_game_serice || 'GS'
    end

    # Know enabled API, EX: gs_api? OR br_api?
    AVAILABLE_SPORT_APIS.each do |method_name|
      define_method "#{method_name.to_s.downcase}?" do
        active == method_name
      end
    end
  end
end
