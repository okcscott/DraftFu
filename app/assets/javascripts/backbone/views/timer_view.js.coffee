class DraftFu.Views.TimerView extends Backbone.View
  template: JST["timer"]
  el: "#timer"

  init: ->
  render: ->
    @$el.html(@template())

  events:
    "click" : "timerClick"

  timerClick: ->
    @trigger("timer:click")

  reset: ->
    #stop any existing timers
    if @timerId
      window.clearInterval @timerId


    #reset the progress bar
    @$('#countdown_bar').css("right","0")

  start: (timestamp)->
    @reset()

    #conver the pick start to a timestamp
    roundEnd = new Date(timestamp)
    roundEnd.setMinutes(roundEnd.getMinutes() + 1)
    @endTimestamp = roundEnd.getTime()

    #create the timer and save its id to clear later
    self = @
    @timerId = window.setInterval(->
      self.timerUpdate()
    , 500)

    @

  pause: ->
    @reset()

  timerUpdate: ->
    seconds = Math.ceil((@endTimestamp - (new Date()).getTime())/1000)
    if seconds <= 0
      @trigger("timer:elapsed")
      window.clearInterval @timerId
      return
    seconds -= 1
    time = Math.floor(seconds / 60) + ":" + (seconds % 60).toFixed().pad(2, "0")
    @$('span').text time
    @$('#countdown_bar').css("right","#{100-((seconds/120)*100)}%")