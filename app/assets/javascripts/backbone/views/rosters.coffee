jQuery ->
  class RosterView extends Backbone.View
    className: 'roster span2'
    tagName: 'div'
    template: _.template(if $('#roster_template').length == 0 then "" else $('#roster_template').html())
    initialize: (options) ->
      @collection.bind 'reset', @render, @
    isCurrent: ->
      return @model.toJSON().round == app.LeagueInfo.toJSON().round and @model.toJSON().pick == app.LeagueInfo.toJSON().pick
    render: ->
      $(@el).html @template(@model.toJSON())
      draftPicksView = new app.DraftboardDraftPicksView
        collection: @collection   
        pick: @model.toJSON().pick
        round: @model.toJSON().round
        current: @isCurrent()   
      $(@el).append draftPicksView.render().el
      @
  class RostersView extends Backbone.View
    el: '#rosters'
    initialize: (options) ->
      @collection.bind "reset", @render, @
    render: ->
      $('#rosters').empty()
      for draftPick in @collection.models
        view = new RosterView
          model: draftPick
          collection: new app.DraftPicks([],
            team_id: draftPick.attributes.team.id
          )
        view.collection.fetch()
        $('#rosters').append view.render().el
      @

  @app = window.app ? {}
  @app.RosterView = RosterView
  @app.RostersView = RostersView