class Api::SearchController < Api::SkipAuthenticationController
  
  def index
    render json: { 
      sports: Sport.search(params[:name]).map{|s| SportSerializer.new(s, scope_name: :current_user)}, 
      tournaments: Tournament.search(params[:name]).map{|s| TournamentSerializer.new(s, scope_name: :current_user)}, 
      teams: Team.search(params[:name]).map{|s| TeamSerializer.new(s, scope_name: :current_user)}
    }
  end
end