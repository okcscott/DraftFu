class PlayersController < ApplicationController
  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end
  
  def create
    @player = Player.new(params[:player])
    if @player.save
      redirect_to players_url, notice: 'Player was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @player = Player.find(params[:id])
  end
  
  def update
    @player = Player.find(params[:id])    
    if @player.update_attributes(params[:player])
      redirect_to players_url, notice: 'Player was successfully updated.'      
    else
      render :edit
    end
  end

end
