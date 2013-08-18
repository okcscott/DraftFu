class DraftFu.Views.DraftView extends Backbone.View
  el: '#wrap'
  initialize: (options) ->
    @leagueInfoView = new DraftFu.Views.LeagueInfoView
      model: @model
    @playersView = new DraftFu.Views.PlayersView 
      collection: app.Players
      league_id: @options.league_id
    
    @draftPicksView = new DraftFu.Views.DraftPicksView
      collection: new DraftFu.Collections.DraftPicks([],
        team_id: @options.team_id
      )
    # @draftedPlayersView = new app.DraftedPlayersView
    #   collection: app.draftedPlayers
    #   roster_spots: @options.roster_spots
    @roundInfoView = new DraftFu.Views.RoundInfoView
      model: @model
      timer: new DraftFu.Timer
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