class DraftController < ApplicationController
  def league
    @league = League.find(params[:league_id])
  end

  def team
  end

  def player
    @team = Team.find(params[:team_id])
    @player = Player.find(params[:player_id])
    @draftPick = @team.league.current_pick
    pick = @team.league.make_pick(params[:team_id],params[:player_id])
    
    render json: pick
  end
end
