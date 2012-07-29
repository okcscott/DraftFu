class DraftController < ApplicationController
  def league
    @league = League.find(params[:league_id])
  end

  def team
  end

  def player
    @team = Team.find(params[:team_id])
    @player = Player.find(params[:player_id])
    @league = @team.league
    @draftPick = @league.current_pick

    #make sure this is the current pick
    if(@draftPick.team_id == @team.id && @league.player_available(@player.id))
      @draftPick.player_id = @player.id
      if @draftPick.save
        @league.move_to_the_next_pick.save
        render json: @draftPick
      else
        render json: @draftPick.errors, status: :unprocessable_entity
      end
    else
      render json: "Error Message", status: :unprocessable_entity
    end
  end
end
