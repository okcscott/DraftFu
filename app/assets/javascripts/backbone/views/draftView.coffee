jQuery ->
  class DraftView extends Backbone.View
    el: '#wrap'
    initialize: (options) ->
      @leagueInfoView = new app.LeagueInfoView
        model: @model
      @playersView = new app.PlayersView 
        collection: app.Players
        league_id: @options.league_id
      @draftedPlayersView = new app.DraftedPlayersView
        collection: app.DraftedPlayers
        roster_spots: @options.roster_spots
      @roundInfoView = new app.RoundInfoView
        model: @model
        timer: new app.Timer()
      @model.bind "change", @render, @
      @leagueInfoView.bind "leagueInfoUpdated", @updateView, @
    updateView: (draftView) ->
      @roundInfoView.render()
      @playersView.search()
      app.DraftedPlayers.fetch()
      # app.Players.fetch()
    render: ->
      @leagueInfoView.render()

  @app = window.app ? {}
  @app.DraftView = DraftView