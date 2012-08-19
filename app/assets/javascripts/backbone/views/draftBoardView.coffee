jQuery ->
  class DraftBoardView extends Backbone.View
    el: '#wrap'
    initialize: (options) ->
      @league_id = @options.league_id
      @leagueInfoView = new app.LeagueInfoView
        model: @model
      @rostersView = new app.RostersView
        roster_spots: @options.roster_spots
        collection: new app.Rosters([],
          league_id: @league_id
        )
      @roundInfoView = new app.RoundInfoView
        model: @model
        timer: new app.Timer
          control: true
          league_id: @league_id

      @model.bind "change", @render, @
      @leagueInfoView.bind "leagueInfoUpdated", @updateView, @
    updateView: (DraftBoardView) ->
      @roundInfoView.render()
      @rostersView.collection.fetch()
    render: ->
      @leagueInfoView.render()

  @app = window.app ? {}
  @app.DraftBoardView = DraftBoardView