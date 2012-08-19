class DraftboardDraftPicksView extends Backbone.View
  className: 'players'
  tagName: 'div'
  initialize: ->
    # @collection.bind 'reset', @test, @
    @pick = @options.pick
    @round = @options.round
    @current = @options.current
  isActive: (pick) ->
    return pick.round == @round and pick.pick == @pick
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
          active: @isActive(draftPickJSON)
          current: @current
          missed: @isActive(draftPickJSON) and draftPickJSON.missed
        $(@el).append view.render().el
    @

@app = window.app ? {}
@app.DraftboardDraftPicksView = DraftboardDraftPicksView  