jQuery ->
  class PickMadeView extends Backbone.View
    el: "#draft_pick_made_modal"
    template: JST["draft_pick_made"]
    initialize: ->
      @team = @options.team
    hide: ->
      $(@el).modal('hide')
    render: ->
      @$('.modal-body').html @template({player: @model, team: @team })
      $(@el).modal()
      @

  @app = window.app ? {}
  @app.PickMadeView = PickMadeView