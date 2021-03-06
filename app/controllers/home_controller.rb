class HomeController < ApplicationController
  # include ImportPlayers
  
  skip_before_filter :require_login
  
  def index
  end
  
  def import
    spider = ImportPlayers::Yahoo.new
    spider.get_player_images
        
    render action: "index", notice: "Player import was successful"
  end

end
