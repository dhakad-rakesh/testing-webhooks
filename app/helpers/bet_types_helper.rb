module BetTypesHelper
  def active_outcome?(bet_slips, opts)
    bet_slips.find do |s|
      s[:market_id] == opts[:market_id] && s[:match_id] == opts[:match_id].to_s && s[:outcome_id] == opts[:outcome_id]
    end
  end
end

