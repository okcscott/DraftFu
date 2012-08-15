jQuery ->
  class PickMadeView extends Backbone.View
    el: "#draft_pick_made_modal"
    template: _.template($('#draft_pick_made_template').html())
    initialize: ->
      @team_name = @options.team_name
    hide: ->
      $(@el).modal('hide')
    render: ->
      @$('.modal-body').html @template({player: @model, team: {name: @team_name} })
      $(@el).modal()
      @

  @app = window.app ? {}
  @app.PickMadeView = PickMadeView