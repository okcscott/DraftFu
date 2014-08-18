class DraftFu.Views.RoundInfoView extends Backbone.View
  el: "#round_info"
  template: JST["round_info"]
  initialize: (current_pick, future_picks)->
    @current_pick = current_pick
    @future_picks = future_picks
  render: ->
    $(@el).html @template(@)
    @resizeText()
    @
  resizeText: ->
    info = $(@el).find('.current_pick .info')
    grade = $(@el).find('.grade span')
    c_height = info.height()
    g_height = 25
    font_size = 20

    loop
      info.css('font-size', font_size)
      c_height = info.height()
      font_size = font_size - 1
      break unless c_height > g_height
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

  update: (current_pick, future_picks) ->
    @current_pick = current_pick
    @future_picks = future_picks
    @render()