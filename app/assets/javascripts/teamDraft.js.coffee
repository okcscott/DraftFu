window.TeamDraft =
  init: (league, current_pick, future_picks, available_players, rosters, team)->
    @league = league
    @current_pick = current_pick
    @team = team

    TeamDraft.timerView = new DraftFu.Views.TimerView()
    TeamDraft.timerView.render()

    TeamDraft.roundInfoView = new DraftFu.Views.RoundInfoView(@current_pick, future_picks)
    TeamDraft.roundInfoView.render()

    TeamDraft.playersView = new DraftFu.Views.DraftPlayersView(@current_pick, available_players, league, rosters, @team)
    TeamDraft.playersView.render()

    DraftFu.Mediator.subscribe("draft:resume", @resumeDraft, {}, @)
    DraftFu.Mediator.subscribe("draft:pause", @pauseDraft, {}, @)
    DraftFu.Mediator.subscribe("pick:made", @draftPickMade, {}, @)
    DraftFu.Mediator.subscribe("pick:missed", @draftPickMissed, {}, @)
    DraftFu.Mediator.subscribe("draft:end", @draftEnd, {}, @)

    unless league.pause
      TeamDraft.timerView.start(@current_pick.timestamp)

  draftEnd: ->
    TeamDraft.playersView.hideModals()
    $('.draftEnd').modal()
    TeamDraft.timerView.pause()

    setTimeout (->
        $('.draftEnd').modal("hide")
      ), 2000

  pauseDraft: ->
    TeamDraft.timerView.pause()

  resumeDraft: (data) ->
    TeamDraft.timerView.start(data.timestamp)

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

  draftPickMade: (data) ->
    #hide other modals and show pick modal
    TeamDraft.playersView.hideModals()

    draftPick = jQuery.parseJSON(data.draftPick)
    @showPickModal(draftPick)

    @update(data)

  draftPickMissed: (data) ->
    #hide other modals and show missed modal
    TeamDraft.playersView.hideModals()

    @showMissedModal()

    @update(data)

  update: (data) ->
      
    #set objects
    @league = jQuery.parseJSON(data.league)
    @current_pick = jQuery.parseJSON(data.currentPick)
    future_picks = jQuery.parseJSON(data.futurePicks)
    available_players = jQuery.parseJSON(data.availablePlayers)
    rosters = jQuery.parseJSON(data.rosters)
    team = jQuery.parseJSON(data.team)
    
    console.log data   

    #update timer
    TeamDraft.timerView.start(@current_pick.timestamp)

    #update round info
    TeamDraft.roundInfoView.update(@current_pick, future_picks)

    #update players view
    TeamDraft.playersView.update(@current_pick, available_players, @league, rosters, team)



    