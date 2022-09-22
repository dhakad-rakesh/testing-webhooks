module Api
  module MyBets
    extend ActiveSupport::Concern
    def fetch_bets(object, params)
      #arguments = { user_id: current_user.id }
      #arguments[:betting_pool_id] = params[:betting_pool_id] if params[:betting_pool_id].present?
      #arguments[:tournament_id] = params[:tournament_id] if params[:tournament_id].present?
      #arguments[:match_id] = params[:match_id] if params[:match_id].present?
      bets =  if params[:combo] == "true"
                current_user.combo_bets.order('created_at DESC')
              else
                current_user.bets.not_combo.order('created_at DESC')
              end
      combo_bets = if params[:bet_type] == "all"
                     current_user.combo_bets.order('created_at DESC')
                   end
      bets = apply_filters(bets) + apply_filters(combo_bets)
      sorted_bets = bets.sort { |a,b| b[:created_at] <=> a[:created_at] }
      sorted_bets.paginate(page: params[:page], per_page: params[:per_page])
    end

    def check_kyc
      return(render_error_response(t('betting.approve_kyc'))) unless current_user.kyc_status == 'Approved'
    end

    def valid_scopes
      ['resolved', 'pending', 'cashed_out', 'won', 'lost', 'live', 'cancelled']
    end

    # On special request of mobile team
    def apply_filters(bets)
      return [] unless bets
      bets = bets.send(params[:scope]) if params[:scope].present? && valid_scopes.include?(params[:scope])
      bets = bets.between(params[:range_from].to_date, params[:range_to].to_date) if params[:range_from] && params[:range_to]
      bets
    end
  end
end
