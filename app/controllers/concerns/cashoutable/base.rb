module Cashoutable
  module Base
    private
    def cashout_bets
      Cashout.new(bets: format_bets(@bet_data), user: current_user, combo: @combo_bet).call
    end

    def format_bets(bets)
      bets.map{ |bet| { id: bet.id, cashout_odd: bet.current_odds }}
    end

    def find_bets
      @bet = Bet.where(id: params[:id])
    end

    def find_combo_bets
      @combo_bet = ComboBet.find_by(id: params[:combo_id])
      @combo_bet ? @combo_bet.bets : [] 
    end

    def is_cashoutable?
      status = @bet_data.map{|bd| bd.cashoutable? }.include? true
      @cashout_error = true if status == false
      status = validate_cahoutable_odds_and_amount if status
      status
    end

    def set_bet_data
      @bet_data = find_combo_bets if params[:combo_id].present?
      @bet_data = find_bets if params[:id].present?
    end

    def validate_cahoutable_odds_and_amount
      if params[:combo_id].present?
        @cashoutable = combo_cashout(@combo_bet)
      elsif params[:id].present?
        @cashoutable = single_cashout(@bet_data.first)
      end
      status = params[:cashoutable].keys.map{|k| params[:cashoutable][k].to_f == @cashoutable[k.to_sym].to_f}.include? false
      @cashoutable_mismatch_error = status
      !status
    end
  end
end
