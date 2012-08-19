jQuery ->
  class ConfirmPickView extends Backbone.View
    el: "#draft_confirm_modal"
    template: _.template($('#player_template').html())
    initialize: ->
    render: ->
      @$('.player').html @template(@model)      
      $(@el).modal()
      @
    events:
      'click .btn-success' : 'draft'
    draft: ->
      @$('.buttons').hide()
      @$('.message').show()
      $.ajax
        type: "POST"
        url: "/api/players/draft"
        data: {team_id: $('#team_id').val(), player_id: @model.id, league_id: $('#league_id').val()}
        success: ->
          app.ConfirmPickView.$el.modal('hide') 
          app.ConfirmPickView.$el.find('.buttons').show()
          app.ConfirmPickView.$el.find('.message').hide()
          

  @app = window.app ? {}
  @app.ConfirmPickView = new ConfirmPickView()