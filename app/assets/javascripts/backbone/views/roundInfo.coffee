jQuery ->
  class RoundInfoView extends Backbone.View
    el: "#round_info"
    template: _.template($('#round_info_template').html())
    initialize: ->
      @timer = @options.timer
    render: ->
      @timer.clear()
      $(@el).html @template(@model.toJSON())      
      @timer.set({seconds: @timeRemaining()})

      @timer.start() unless @model.toJSON().pause
      @    
    events:
      'click .pause' : 'pause'
      'click .resume' : 'resume'
    pause: ->
      $.ajax
        type: "POST"
        url: "/api/leagues/pause_draft"
        data: {league_id: @model.toJSON().league_id}        
    resume: ->
      $.ajax
        type: "POST"
        url: "/api/leagues/resume_draft"
        data: {league_id: @model.toJSON().league_id}        
    timeRemaining: ->
      roundStart = new Date(@model.get("timestamp"))
      roundEnd = new Date(@model.get("timestamp"))
      roundEnd.setMinutes(roundEnd.getMinutes() + 2)
      now = new Date()
      String(Math.max(0,(roundEnd.getTime() - now.getTime())/1000))

  @app = window.app ? {}
  @app.RoundInfoView = RoundInfoView