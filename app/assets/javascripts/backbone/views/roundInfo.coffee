class DraftFu.Views.RoundInfoView extends Backbone.View
  el: "#round_info"
  template: JST["round_info"]
  initialize: ->
    @timer = @options.timer
  render: ->
    @timer.clear()
    $(@el).html @template(@model.toJSON())
    @setTimer()
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
  setTimer: ->
    roundEnd = new Date(@model.toJSON().timestamp*1000)
    roundEnd.setMinutes(roundEnd.getMinutes() + 2)
    @timer.set({endTimestamp: roundEnd.getTime()})
  timeRemaining: ->
    roundStart = new Date(@model.get("timestamp"))
    roundEnd = new Date(@model.get("timestamp"))
    roundEnd.setMinutes(roundEnd.getMinutes() + 2)
    now = new Date()
    String(Math.max(0,(roundEnd.getTime() - now.getTime())/1000))