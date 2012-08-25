class Api::LeaguesController < ApplicationController
  respond_to :json
  def current_pick
    @league = League.find(params[:league_id])
    current_pick = @league.current_pick
    render json: {team_name: current_pick.team.name, team_id: current_pick.team.id, round: current_pick.round, pick: current_pick.pick, timestamp: current_pick.timestamp, pause: @league.pause, league_id: @league.id, image: current_pick.team.image, win_pct: current_pick.team.win_pct, championships: current_pick.team.championships, avg_place: current_pick.team.avg_place}
  end

  def start_draft
    @league = League.find(params[:league_id])
    @teams = Team.where(league_id: params[:league_id]).order(:pick)
    total_teams = @league.teams.count
    total_rounds = @league.roster_spots
    total_picks = total_teams * total_rounds

    round = 1
    pick = 1

    for i in 1..total_picks
      #find the right team
      index = round.odd? ? (pick - 1) : (pick - total_teams).abs

      draft_pick = DraftPick.new(round: round, pick: pick, team_id: @teams[index].id, league_id: @league.id)
      draft_pick.save

      if pick == total_teams
        round += 1
        pick = 1
      else
        pick += 1
      end
    end
  end

  def picks_queue
    number_of_picks = params[:number_of_picks] || 4
    @league = League.find(params[:league_id])

    @draft_picks = DraftPick.where(league_id: @league.id, player_id: nil).limit(number_of_picks)
    @last_picks = DraftPick.unscoped.where("league_id = ? and player_id is not NULL", @league.id).order("updated_at DESC").limit(2)
    
    # picks = [@last_pick]
    # picks = picks + @draft_picks
    picks = @last_picks.reverse + @draft_picks

    render json: picks, include: :team
  end

  def missed_pick
    @league = League.find(params[:league_id])
    @current_pick = @league.current_pick
    @current_pick.missed = true
    @current_pick.save

    next_pick = @league.next_pick

    #this is to check to make sure that we aren't just cyclincg back to the current pick
    if next_pick.round == @current_pick.round && next_pick.pick == @current_pick.pick
      next_pick = @league.available_picks.second
    end

    next_pick.timestamp = Time.now
    @league.move_to_pick(next_pick)
    @league.save
    next_pick.save


    Pusher['draft'].trigger('pick_missed', {:message => {draftPick: @current_pick.to_json, team: @current_pick.team}})
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def pause_draft
    @league = League.find(params[:league_id])
    @league.pause = true
    @league.save
    Pusher['draft'].trigger('pause', {})
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def resume_draft
    @league = League.find(params[:league_id])
    @league.pause = false
    current_pick = @league.current_pick
    current_pick.timestamp = Time.now
    current_pick.save
    @league.save
    Pusher['draft'].trigger('resume', {})
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end
end
