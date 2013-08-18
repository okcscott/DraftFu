class DraftFu.Views.DraftPicksView extends Backbone.View
  el: "#drafted_players_list"
  initialize: ->
    @collection.bind 'reset', @render, @
  render: ->
    $(@el).empty()
    for draftPick in @collection.models
      draftPickJSON = draftPick.toJSON()
      if draftPickJSON.player_id?
        view = new DraftFu.Views.PlayerView 
          model: draftPickJSON.player,
          team_id: null,
          league_id: null,
          draftable: false,
          round: draftPickJSON.round
        $(@el).append view.render().el
      else    
        view = new DraftFu.Views.UndraftedPlayerView
          round: draftPickJSON.round
        $(@el).append view.render().el