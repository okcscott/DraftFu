class TeamsController < ApplicationController
  def new
    @team = current_user.leagues.find(params[:league_id]).teams.new
  end

  def create
    @league = current_user.leagues.find(params[:team][:league_id])
    @team = @league.teams.new(params[:team])
    
    if @team.save
      redirect_to league_url(@league), notice: "Team was successfully created."
    else
      render :new
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      redirect_to league_url(@team.league), notice: 'Team was successfully updated.'      
    else
      render :edit
    end
  end
  
  def draft
    @team = Team.find(params[:id])
    @players = @team.league.available_players
  end

end
