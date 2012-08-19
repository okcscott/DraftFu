class DraftPicksView extends Backbone.View
  el: "#drafted_players_list"
  initialize: ->
    @collection.bind 'reset', @render, @
  render: ->
    $(@el).empty()
    for draftPick in @collection.models
      draftPickJSON = draftPick.toJSON()
      if draftPickJSON.player_id?
        view = new app.PlayerView 
          model: draftPickJSON.player,
          team_id: null,
          league_id: null,
          draftable: false,
          round: draftPickJSON.round
        $(@el).append view.render().el
      else    
        view = new app.UndraftedPlayerView
          round: draftPickJSON.round
        $(@el).append view.render().el

@app = window.app ? {}
@app.DraftPicksView = DraftPicksView  