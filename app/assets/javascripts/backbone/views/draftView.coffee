jQuery ->
  class DraftView extends Backbone.View
    el: '#wrap'
    initialize: (options) ->
      @leagueInfoView = new app.LeagueInfoView
        model: @model
      @playersView = new app.PlayersView 
        collection: app.Players
        league_id: @options.league_id
      
      @draftPicksView = new app.DraftPicksView
        collection: new app.DraftPicks([],
          team_id: @options.team_id
        )
      # @draftedPlayersView = new app.DraftedPlayersView
      #   collection: app.draftedPlayers
      #   roster_spots: @options.roster_spots
      @roundInfoView = new app.RoundInfoView
        model: @model
        timer: new app.Timer
          control: false
          league_id: @options.league_id
      @model.bind "change", @render, @
      @leagueInfoView.bind "leagueInfoUpdated", @updateView, @
    updateView: (draftView) ->
      @roundInfoView.render()
      @playersView.search()
      @draftPicksView.collection.team_id = $('#team_id').val()
      @draftPicksView.collection.fetch()
      # app.draftedPlayers.fetch()      
      app.Players.fetch()
    render: ->
      @leagueInfoView.render()

  @app = window.app ? {}
  @app.DraftView = DraftView