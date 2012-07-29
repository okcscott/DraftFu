class LeaguesController < ApplicationController
  
  def index
    @leagues = current_user.leagues
  end

  def new
    @league = League.new
  end
  
  def create
    @league = League.new(params[:league])
    @league.commissioner = current_user
    if @league.save
      redirect_to leagues_url, notice: 'League was successfully created.'
    else
      render action: "new"
    end
  end

  def edit
    @league = League.find(params[:id])
  end
  
  def update
    @league = League.find(params[:id])
    
    if @league.update_attributes(params[:league])
      redirect_to leagues_url, notice: 'League was successfully updated.'      
    else
      render :edit
    end
  end
  
  def show
    @league = League.find(params[:id])
  end

  def draft
    @league = League.find(params[:id])
  end

end
