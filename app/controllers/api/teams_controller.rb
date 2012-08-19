class Api::TeamsController < ApplicationController
  respond_to :json
  def draft_picks
    @team = Team.find(params[:team_id])
    render json: @team.draftPicks, include: :player
  end
end
