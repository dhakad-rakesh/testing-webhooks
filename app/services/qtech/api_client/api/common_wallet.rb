module Qtech
  module ApiClient
    module Api
      # All API require below headers
      # Pass-Key: 76236f90-dc9c-36d7-9e78-3e716d5ecf92
      # Wallet-Session: 568dbe0a57f5d33d34b22d0e
      module CommonWallet
        # Every time a player launches a game, the player session will be validated and verified in the Operator system.
        def verify_session(player_id, game_id)
          get("accounts/#{player_id}/session?gameId=#{game_id}")
        end

        # The Get Balance endpoint is being called from time-to-time update the balance within the game.
        def fetch_balance(player_id, game_id)
          get("accounts/#{player_id}/balance?gameId=#{game_id}")
        end

        # When placing a bet in a game, the bet amount will be withdrawn from the player's balance in the Operator
        # system
        # E.g. args
        # {
        #  "txnType":"DEBIT",
        #  "txnId":"568cc95f57f5d33b96f379ab",
        #  "playerId":"test123",
        #  "roundId":"568cc92f57f5d33b95846124",
        #  "amount":80.00,
        #  "currency":"CNY",
        #  "jpContribution":0.003,
        #  "gameId":"TK-froggrog",
        #  "device":"MOBILE",
        #  "clientType":"HTML5",
        #  "clientRoundId":"123456",
        #  "category":"CASINO/SLOT/5REEL",
        #  "created":"2015-10-22T20:34:59.703+08:00[Asia/Shanghai]",
        #  "completed":"false"
        # }
        def withdrawal(args = {})
          post('transactions', args)
        end

        # In case of winning, the payout amount will be deposited to the player's balance in the Operator system.
        # {
        #  "txnType":"CREDIT",
        #  "txnId":"5693761657f5d346ec6749a1",
        #  "betId":"568cc95f57f5d33b96f379ab",
        #  "playerId":"test123",
        #  "roundId":"568cc92f57f5d33b95846124",
        #  "amount":80.00,
        #  "currency":"CNY",
        #  "jpPayout":10.00,
        #  "gameId":"TK-froggrog",
        #  "device":"MOBILE",
        #  "clientType":"HTML5",
        #  "clientRoundId":"123456",
        #  "category":"CASINO/SLOT/5REEL",
        #  "created":"2015-10-22T20:34:59.703+08:00[Asia/Shanghai]",
        #  "completed":"true"
        # }
        def deposit(args = {})
          post('transactions', args)
        end

        # Sometimes things can go wrong. For example, if the player gets disconnected from the game server or if there are
        # any the wallet miscommunications. In case of these rare errors, a cancellation can be issued to rollback the last
        # bet to return the bet amount to the player's account.
        def rollback(args = {})
          post('transactions/rollback', args)
        end

        # The Promotion Status method is related to free round promotions and is optional to implement.
        # {
        #  "bonusId": "bonus-b",
        #  "playerId":"45465",
        #  "gameIds": ["QS-goldlab"],
        #  "totalBetValue":100.00,
        #  "roundOptions":[1,2,4,8],
        #  "currency":"CNY",
        #  "promoCode":"ABC",
        #  "status":"CLAIMED", // status can be PROMOTED CLAIMED IN_PROGRESS COMPLETED DELETED CANCELLED FAILED EXPIRED
        #  "validityDays":7,
        #  "claimedRoundOption":1,
        #  "claimedGameId":"QS-goldlab",
        #  "promotedDateTime":"2019-01-01T00:00:00+08:00[Asia/Shanghai]",
        #  "claimedDateTime":"2019-01-01T00:00:00+08:00[Asia/Shanghai]"
        # }
        def promotional_status(args = {})
          post('bonus/status', args)
        end
      end
    end
  end
end
