class DraftFu.Views.PlayerView extends Backbone.View
  className: 'player'
  tagName: 'div'
  template: JST["draftable_player"]
  initialize: ->
    @team_id = @options.team_id
    @league_id = @options.league_id
    @draftable = @options.draftable
    @round = @options.round
    @model.draftable = @options.draftable
  render: ->
    $(@el).html @template(@model)
    @
  events:
    'click .draft' : 'draft'
  draft: ->
    view = new DraftFu.Views.ConfirmPickView()
    view.model = @model
    view.render()

class DraftFu.Views.UndraftedPlayerView extends Backbone.View
  className: 'undrafted'
  tagName: 'div'
  template: JST["empty_pick"]
  initialize: ->
    @round = @options.round
    @active = @options.active      
    @current = @options.current
    @missed = @options.missed
  render: ->
    $(@el).html @template({round: @round})
    $(@el).addClass('active') if @active
    $(@el).addClass('current') if @current
    $(@el).addClass('missed') if @missed
    @

class DraftFu.Views.PlayersView extends Backbone.View
  el: "#available_players"
  initialize: ->
    @collection.bind 'reset', @render, @
    @team_id = @options.team_id
    @league_id = @options.league_id   
    @position = "" 
  render: ->
    $('#player_list').empty()
    for player in @collection.models
      view = new DraftFu.Views.PlayerView 
        model: player.toJSON(),
        team_id: @team_id,
        league_id: @league_id,
        draftable: @isDraftable()
      $('#player_list').append view.render().el
    @
  events:
    'keypress .player_search' : 'searchOnEnter'
    'click .player_search_button': 'search'
    'click .filters .positions a': 'positionSearch'
  isDraftable: ->
    $('#team_id').val() == $('#current_team').val()
  positionSearch: (element) ->
    $('.filters .positions a').removeClass('active')
    $choice = $(element.target)
    $choice.addClass('active')
    @position = if $choice.text() == "All" then "" else $choice.text()
    @search()

  searchOnEnter: (event) ->
    if (event.keyCode is 13) # ENTER
      @search()
  search: ->
    name = $('input.player_search').val()
    @collection.fetch({ data: {name: name, position: @position}})

class DraftFu.Views.DraftedPlayersView extends Backbone.View
  el: "#drafted_players_list"
  initialize: ->
    @collection.bind 'reset', @render, @
    @roster_spots = @options.roster_spots
  render: ->
    $(@el).empty()
    i = 0
    while i < @roster_spots
      if i < @collection.length
        view = new PlayerView 
          model: @collection.models[i],
          team_id: null,
          league_id: null,
          draftable: false,
          round: i+1
        $(@el).append view.render().el
      else
        view = new UndraftedPlayerView
          round: i+1
        $(@el).append view.render().el
      i++