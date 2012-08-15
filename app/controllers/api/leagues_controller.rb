class Api::LeaguesController < ApplicationController
  respond_to :json
  def current_pick
    @league = League.find(params[:league_id])
    current_pick = @league.current_pick
    render json: {team_name: current_pick.team.name, team_id: current_pick.team.id, round: current_pick.round, pick: current_pick.pick, timestamp: current_pick.timestamp}
  end
end
