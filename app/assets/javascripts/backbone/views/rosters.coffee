class DraftFu.Views.RosterView extends Backbone.View
  className: 'roster span2'
  tagName: 'div'
  template: JST["roster"]
  initialize: (options) ->
    @collection.bind 'reset', @render, @
  render: ->
    $(@el).html @template(@model.toJSON())
    draftPicksView = new DraftFu.Views.DraftboardDraftPicksView
      collection: @collection   
      pick: @model.toJSON().pick
      round: @model.toJSON().round
    $(@el).append draftPicksView.render().el
    @
class DraftFu.Views.RostersViewOld extends Backbone.View
  el: '#rosters'
  initialize: (options) ->
    @collection.bind "reset", @render, @
  render: ->
    $('#rosters').empty()
    for draftPick in @collection.models
      view = new DraftFu.Views.RosterView
        model: draftPick
        collection: new DraftFu.Collections.DraftPicks([],
          team_id: draftPick.attributes.team.id
        )
      view.collection.fetch()
      $('#rosters').append view.render().el
    @