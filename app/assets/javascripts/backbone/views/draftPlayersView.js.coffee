class DraftFu.Views.DraftPlayersView extends Backbone.View
  template: JST["draft_players"]
  el: "#players"

  initialize: (current_pick, available_players, league, rosters, team)->
    @current_pick = current_pick
    @available_players = available_players
    @league = league
    @rosters = rosters
    @team = team
    @static_roster = @team?
    console.log @static_roster
    @position_filter = ""

    @availablePlayersView = new DraftFu.Views.AvailablePlayersView()
    @draftDraftBoardView = new DraftFu.Views.DraftDraftBoardView()

  render: ->
    @$el.html(@template(@))
    @$el.find("#available_players").html @availablePlayersView.render(@available_players, @currentTeam())
    @$el.find("#scrolling_draft_board .table_wrapper").html @draftDraftBoardView.render(@rosters)

  events:
    'click #players_nav span' : 'switch_view'
    'click .filters span' : 'filter_click'
    "keyup .filters input" : "filter"
    "click #scrolling_draft_board .control" : "draftboard_click"
    "click .available_player.draftable" : "confirmPick"
    "click .confirmModal .btn-primary" : "makePick"

  update: (current_pick, available_players, league, rosters, team)->
    @current_pick = current_pick
    @available_players = available_players
    @league = league
    @rosters = rosters
    @position_filter = ""
    @team = team if (@static_roster and (team.id is @team.id))
    @render()

  currentTeam: ->
    (!@team?) or @team.id == @current_pick.team_id

  draft_pick_made: (data)->
    @current_pick = data
    @show_pick_modal()

  hideModals: ->
    $('.confirmModal, .submittingModal, .errorModal').modal("hide")
    
  show_pick_modal: ->
    $('.confirmModal, .submittingModal, .errorModal').modal("hide")
    $('.pickMadeModal .team_name').html(@current_pick.team.name)
    $('.pickMadeModal .player_name').html(@current_pick.player.name)
    $('.pickMadeModal').modal()

    setTimeout (->
        $('.pickMadeModal').modal("hide")
      ), 2000

  confirmPick: (e) ->
    player = $(e.currentTarget)
    $('.confirmModal .player').html(player.data("name"))
    $('.confirmModal .btn-primary').data("player_id", player.data("id"))
    $('.confirmModal').modal()

  makePick: (e) ->
    $('.confirmModal').modal("hide")
    $('.submittingModal').modal()

    player_id = $(e.currentTarget).data("player_id")
    $.ajax
      type: "POST"
      url: "/api/players/draft"
      data: {team_id: @current_pick.team_id, player_id: player_id, league_id: @league.id}
      error: (jqXHR, textStatus, errorThrown)->        
        $('.submittingModal').modal("hide")
        $('.errorModal .reason').html(jqXHR.responseText)
        $('.errorModal').modal()


  draftboard_click: (e) ->
    control = $(e.currentTarget)

    if control.hasClass("inactive")
      @$el.find("#scrolling_draft_board .table_wrapper").css('max-height','500px')
      control.removeClass("inactive")
    else
      @$el.find("#scrolling_draft_board .table_wrapper").css('max-height','0px')
      control.addClass("inactive")

  filter_click: (e) ->
    position = $(e.currentTarget)
    unless position.hasClass('active')
      @$('.filters span').removeClass('active')
      position.addClass('active')
      @position_filter = position.data("position")
      @filter()
    
  filter: ->
    self = @
    $.getJSON "/api/players/available.json",
      league_id: @league.id
      position: @position_filter
      name: @$el.find('.player_search').val()
    , (data) ->
      self.$el.find("#available_players").html self.availablePlayersView.render(data, self.currentTeam())

  switch_view: (e) ->
    nav_control = $(e.currentTarget)
    unless nav_control.hasClass('active')
      @$('#player_nav span').removeClass('active')
      nav_control.addClass('active')
