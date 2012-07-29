class Api::PlayersController < ApplicationController
  before_filter :find_league
  respond_to :json
  def index
    limit = params[:count] || 100
    @players = Player.limit(limit)
    respond_with(@players)
  end

  def available
    limit = params[:count]
    name = params[:name]
    position = params[:position]
    #get the ID's of selected players
    player_ids = @league.players.map(&:id)

    #get the rest of them    
    player_scope = Player.exclude(player_ids).limit(limit)

    if name
      player_scope = player_scope.where("(LOWER(players.name) LIKE ?)", "%#{name}%")
    end

    if position
      player_scope = player_scope.where("players.position = ?", position)
    end

    respond_with player_scope
  end

  def find_league
    league_id = params[:league_id]
    if league_id
      @league = League.find(league_id)
    end
  end

  def draft
    @team = Team.find(params[:team_id])
    @player = Player.find(params[:player_id])
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
