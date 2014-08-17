class LeaguesController < ApplicationController
  before_filter :require_login
  before_filter :validate_commissioner, except: :index

  def validate_commissioner
    league = League.find(params[:id])
    if !league.nil?
      if current_user.id != league.commissioner_id
        redirect_to root_url, :alert => "First login to access this page."
      end
    end
  end

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

  def setup_draft
    @league = League.find(params[:id])
    @teams = Team.where(league_id: params[:id]).order(:pick)
    total_teams = @league.teams.count
    total_rounds = @league.roster_spots
    total_picks = total_teams * total_rounds

    round = 1
    pick = 1

    for i in 1..total_picks

      #which order are the teams in / snake draft
      teams_in_order_for_round = round.odd? ? @teams : @teams.reverse

      DraftPick.create(round: round, pick: pick, team_id: teams_in_order_for_round[pick-1].id, league_id: @league.id)

      if pick == total_teams
        round += 1
        pick = 1
      else
        pick += 1
      end
    end

    @league.update_attributes(round: 1, pick: 1, pause: true)

    redirect_to league_url(@league.id)
  end

  def draft
    @league = League.find(params[:id])
    @current_pick = @league.current_pick
    @upcoming_picks = DraftPick.where("league_id = ? AND player_id is NULL AND id != ?", params[:id], @current_pick.id).limit(9).order("round desc, pick desc")
    @available_players = Player.available_for_league(params[:id]).limit(10)
    @rosters = Team.where(league_id: params[:id]).order(:pick)
  end

  def draftboard
    @league = League.find(params[:id])
    @current_pick = @league.current_pick
    @rosters = Team.where(league_id: params[:id]).order(:pick)
    @upcoming_picks = DraftPick.where("league_id = ? AND player_id is NULL AND id != ?", params[:id], @current_pick.id).limit(9).order("round desc, pick desc")
  end

  def team_draft
    @league = League.find(params[:id])
    @current_pick = @league.current_pick
    @upcoming_picks = DraftPick.where("league_id = ? AND player_id is NULL AND id != ?", params[:id], @current_pick.id).limit(9).order("round desc, pick desc")
    @available_players = Player.available_for_league(params[:id]).limit(10)
    @rosters = Team.where(league_id: params[:id]).order(:pick)
  end
end
