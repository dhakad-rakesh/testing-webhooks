module Casino
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
        'uuid'=> "#{format('%.5d', current_user.id)}#{Time.now.to_i}",
        'player'=> {
          'id'=> "#{current_user.id}",
          'update'=> false,
          'country'=> Constants::DEFAULT_COUNTRY,
          'language'=> language || Constants::DEFAULT_LANGUAGE ,
          'currency'=> Constants::DEFAULT_CURRENCY,
          'session'=> {
            'id'=> current_user.generate_access_token&.token,
            'ip'=> ip
          },
          'group'=> {
              'id' => 'htftyftufu',
              'action'=> 'assign'
          }
        },
        'config'=> {
          'game'=> {
            'category'=> game.item_type,
            'table'=> {
              'id'=> game.uuid
            }
          },
          'channel'=> {
            'wrapped'=> false
          }
        }
      }
    end
  end
end
