module Casino
  class CreateMenusAndAssignItems
    class << self
      NON_LIVE_MENUES = ['TOP GAMES', 'TABLE GAMES', 'POKER', 'SLOTS', 'SOFT GAMES', 'OTHER'].freeze
      LIVE_MENUES = %w[ALL POKER TABLE ROULETTE LOTTERY BLACKJACK BACCARAT OTHER].freeze

      def execute
        create_casino_menus
        assign_items_to_menues
      end

      def create_casino_menus
        LIVE_MENUES.each.with_index(NON_LIVE_MENUES.count + 1) do |menu_name, index|
          casino_menu = CasinoMenu.find_or_create_by(name: menu_name, menu_type: :live) do |menu|
            menu.menu_order = index
          end

          send(menu_name.downcase.gsub(' ', '_'), casino_menu.id, 'live')
        end

        NON_LIVE_MENUES.each.with_index(1) do |menu_name, index|
          casino_menu = CasinoMenu.find_or_create_by(name: menu_name, menu_type: :non_live) do |menu|
            menu.menu_order = index
          end

          send(menu_name.downcase.gsub(' ', '_'), casino_menu.id, 'non_live')
        end
      end

      def assign_items_to_menues; end

      # NON LIVE CASINO ITEMS
      def top_games(menu_id, _type)
        game_names = ['Lucky Staxx: 40 Lines Mobile', 'CRANKY FLAVOR', 'MYSTIC JUNGLE', 'BURNING FRUITS',
                      'Sunny Fruits: Hold and Win Mobile', 'Imperial Fruits: 100 lines Mobile',
                      'Fruits of the Nile Mobile', 'Rise of Egypt Mobile', 'Scarab Riches',
                      'Dun of Egypt', 'Bison Trail', 'MESOZOIC TALES', 'Fireworks Master Mobile',
                      'Fruits and Jokers: 100 Lines Mobile', 'Claws vs Paws Mobile', 'Hot’n’Fruity',
                      'Book of Gold: Classic Mobile', 'Book of Gold: Symbol Choice Mobile',
                      'Book of Gold: Double Chance Mobile', 'Wild Burning Wins: 5 lines Mobile',
                      'Lucky Seven', 'LUCKY SEVEN', 'Grand Dragon', 'Red Seven', 'Chinese Tigers',
                      'ZUMBAZI', 'HIDDEN CHARM', 'Book Of Spells', 'Star Gems', 'FILIBUSTERS GHOST',
                      'BEARS CORNER', 'QUICK STAMP', 'Red Lights', 'Wild 888', 'Book of Sun',
                      'MIGHTY ZOO', 'Pharaoh’s Empire', 'Monkey Money', 'Fortune Multiplier',
                      'Halloween Witch', 'Red Chilli Wins mobile']

        casino_items = CasinoItem.where(name: game_names, casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      def table_games(menu_id, _type)
        # Games have provider 'Betsoft' and type equal to table
        # and Games have name of ROULETTE and BLACKJACK

        table_items = []
        casino_items = CasinoItem.where(provider: 'Betsoft', item_type: 'table', casino_menu_id: nil)
        %w[ROULETTE BLACKJACK].each do |name|
          table_items << casino_items.where('lower(name) ilike  ?', "%#{name.downcase}%")
        end
        casino_items = CasinoItem.where(id: table_items.flatten!.pluck(:id), casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      def slots(menu_id, _type)
        casino_items = CasinoItem.where(item_type: 'slots', casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      def soft_games(menu_id, _type)
        game_names = ['Power Keno', 'Keno', 'Super Keno', 'Instant Keno 40 Ball',
                      'Instant Keno 80 Ball', 'Klub Keno', 'Scratch Card',
                      'Predictor', 'Scratcherz', 'Virtual Racebook 3D',
                      'MAX QUEST: WRATH OF RA']

        casino_items = CasinoItem.where(name: game_names, casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      # LIVE CASINO ITEMS
      def all(menu_id, _type)
        game_names = ["Casino Hold'em", 'Auto Roulette',
                      'Wheel Of Fortune', 'Roulette', 'Blackjack', 'Dice Duel']
        casino_items = CasinoItem.where(name: game_names, casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      def table(menu_id, _type)
        game_names = ['War Of Bets']
        casino_items = CasinoItem.where(name: game_names, casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      def roulette(menu_id, _type)
        game_names = ['Auto Roulette', "Casino Hold'em", 'Roulette with track high',
                      'Roulette with track Mobile', 'Roulette with track low', 'Auto Roulette',
                      'Roulette with track', 'Roulette with track low Mobile',
                      'Roulette with track high Mobile', 'Roulette', 'European Roulette',
                      'American Roulette']

        casino_items = CasinoItem.where(name: game_names, casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      def lottery(menu_id, _type)
        game_names = ['Wheel Of Fortune', 'Lucky 5', 'Lucky 7', 'Lucky 6', 'Dice Duel']
        casino_items = CasinoItem.where(name: game_names, casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      def blackjack(menu_id, _type)
        game_names = ["Casino Hold'em", 'Blackjack High',
                      'Blackjack Low', 'Blackjack Low Mobile', 'Blackjack Mid',
                      'Blackjack High Mobile', 'Blackjack Mid Mobile', 'Blackjack',
                      'Black Jack Mobile', 'Black Jack', 'Black Jack', 'Black Jack VIP']

        casino_items = CasinoItem.where(name: game_names, casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      def baccarat(menu_id, _type)
        game_uids = %w[87c5f36aee08189eab9e6fcbd63c3c16f0f46464 1566861abf92c6f502d0f2c2a4d47461ff626d7c]
        casino_items = CasinoItem.where(uuid: game_uids, casino_menu_id: nil)
        casino_items.update_all(casino_menu_id: menu_id)
      end

      # COMMON
      def poker(menu_id, type)
        if type == 'non_live'
          # Multihand poker + video poker + pyramid poker
          casino_items = CasinoItem.where(item_type: 'poker', casino_menu_id: nil)
          casino_items.update_all(casino_menu_id: menu_id)
        else
          game_names = ['6+ Poker', 'Bet-on-Poker', 'Speedy 7']
          casino_items = CasinoItem.where(name: game_names, casino_menu_id: nil)
          casino_items.update_all(casino_menu_id: menu_id)
        end
      end

      def other(menu_id, type)
        if type == 'non_live'
          casino_items = CasinoItem.where(casino_menu_id: nil)
          casino_items.update_all(casino_menu_id: menu_id)
        end
      end
    end
  end
end
