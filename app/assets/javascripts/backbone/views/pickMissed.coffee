jQuery ->
  class PickMissedView extends Backbone.View
    el: "#draft_pick_missed_modal"
    template: _.template($('#draft_pick_missed_template').html())
    initialize: ->
      @team_name = @options.team_name
    hide: ->
      $(@el).modal('hide')
    render: ->
      @$('.modal-body').html @template({team: {name: @team_name} })
      $(@el).modal()
      @

  @app = window.app ? {}
  @app.PickMissedView = PickMissedView