window.Draftboard =
  init: (league, current_pick, future_picks, rosters)->
    @league = league
    @current_pick = current_pick

    Draftboard.timerView = new DraftFu.Views.TimerView()
    Draftboard.timerView.render()

    Draftboard.roundInfoView = new DraftFu.Views.RoundInfoView(current_pick, future_picks)
    Draftboard.roundInfoView.render()

    Draftboard.rostersView = new DraftFu.Views.RostersView(rosters, current_pick)
    Draftboard.rostersView.render()

    Draftboard.dashboardView = new DraftFu.Views.DashboardView(current_pick)
    Draftboard.dashboardView.render()

    Draftboard.timerView.bind("timer:click", @timerClick, @)
    Draftboard.timerView.bind("timer:elapsed", @timerElapsed, @)
    DraftFu.Mediator.subscribe("draft:resume", @resumeDraft, {}, @)
    DraftFu.Mediator.subscribe("draft:pause", @pauseDraft, {}, @)
    DraftFu.Mediator.subscribe("pick:made", @draftPickMade, {}, @)
    DraftFu.Mediator.subscribe("pick:missed", @draftPickMissed, {}, @)
    DraftFu.Mediator.subscribe("draft:end", @draftEnd, {}, @)

    unless @league.pause
      Draftboard.timerView.start(current_pick.timestamp)
  draftEnd: (data) ->
    $('.draftEnd').modal()
    @update(data)
    Draftboard.timerView.pause()

    setTimeout (->
        $('.draftEnd').modal("hide")
      ), 2000

  showPickModal: (current_pick) ->
    $('.pickMadeModal .team_name').html(current_pick.team.name)
    $('.pickMadeModal .player_name').html(current_pick.player.name)
    $('.pickMadeModal').modal()

    setTimeout (->
        $('.pickMadeModal').modal("hide")
      ), 2000

  showMissedModal: ->
    $('.pickMissedModal .team_name').html(@current_pick.team.name)
    $('.pickMissedModal').modal()

    setTimeout (->
        $('.pickMissedModal').modal("hide")
      ), 2000

  draftPickMissed: (data) ->
    @showMissedModal()

    @update(data)

  draftPickMade: (data) ->
    draftPick = jQuery.parseJSON(data.draftPick)
    @showPickModal(draftPick)

    @update(data)

  update: (data) ->

    #set objects
    @league = jQuery.parseJSON(data.league)
    @current_pick = jQuery.parseJSON(data.currentPick)
    future_picks = jQuery.parseJSON(data.futurePicks)
    available_players = jQuery.parseJSON(data.availablePlayers)
    rosters = jQuery.parseJSON(data.rosters)

    #update timer
    Draftboard.timerView.start(@current_pick.timestamp)

    # update round info
    Draftboard.roundInfoView.update(@current_pick, future_picks)

    #update rosters view
    Draftboard.rostersView.update(rosters, @current_pick)

    Draftboard.dashboardView.update(@current_pick)

  pauseDraft: ->
    Draftboard.timerView.pause()

  resumeDraft: (data) ->
    console.log data
    Draftboard.timerView.start(data.timestamp)

  timerElapsed: ->
    $.ajax
      type: "POST"
      url: "/api/leagues/missed_pick"
      data: {league_id: @league.id}

  timerClick: ->
    if @league.pause
      @league.pause = false
      $.ajax
        type: "POST"
        url: "/api/leagues/resume_draft"
        data: {league_id: @league.id}
    else
      @league.pause = true
      $.ajax
        type: "POST"
        url: "/api/leagues/pause_draft"
        data: {league_id: @league.id}


