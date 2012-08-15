class TeamsController < ApplicationController
  def new
    @league = League.find(params[:league_id])
    @team = @league.teams.new
  end

  def create
    @league = current_user.leagues.find(params[:team][:league_id])
    @team = @league.teams.new(params[:team])
    
    if @team.save
      redirect_to league_url(@league.id), notice: "Team was successfully created."
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
    @league = League.find(params[:league_id])
    @current_pick = @league.current_pick
  end

end
