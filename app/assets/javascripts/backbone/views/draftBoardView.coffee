class DraftFu.Views.DraftBoardView extends Backbone.View
  el: '#wrap'
  initialize: (options) ->
    @league_id = @options.league_id
    @leagueInfoView = new DraftFu.Views.LeagueInfoView
      model: @model
    @rostersView = new DraftFu.Views.RostersView
      roster_spots: @options.roster_spots
      collection: new DraftFu.Collections.Rosters([],
        league_id: @league_id
      )
    @roundInfoView = new DraftFu.Views.RoundInfoView
      model: @model
      timer: new DraftFu.Timer
        control: true
        league_id: @league_id

    @model.bind "change", @render, @
    @leagueInfoView.bind "leagueInfoUpdated", @updateView, @
  pause: ->
    console.log "pause"
  updateView: (DraftBoardView) ->
    @roundInfoView.render()
    @rostersView.collection.fetch()
  render: ->
    @leagueInfoView.render()