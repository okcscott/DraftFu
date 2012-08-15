class Timer extends Backbone.Model
  convertTimeToSeconds : (time) ->
    minutes = parseInt(time.split(":")[0], 10)
    seconds = parseInt(time.split(":")[1], 10)
    (minutes * 60) + seconds
  timerUpdate : ->
    seconds = @convertTimeToSeconds($(".draft_clock span").text())
    if seconds <= 0
      window.clearInterval @get("timerId")
      return
    seconds -= 1
    time = Math.floor(seconds / 60) + ":" + (seconds % 60).toFixed().pad(2, "0")
    $(".draft_clock span").text time
  pause: ->
    window.clearInterval @get("timerId")
    remaining = @convertTimeToSeconds($(".draft_clock span").text())
  resume: ->
    timer = @
    timerId = window.setInterval(->
        timer.timerUpdate()
      , 1000)
    @set({timerId : timerId})
  clear: ->
    timer = @
    window.clearInterval timer.get("timerId")
  reset: ->
    @clear()
    @start()
  start : ->
    time = Math.floor(@get("seconds") / 60) + ":" + (@get("seconds") % 60).toFixed().pad(2, "0")
    $(".draft_clock span").text(time)
    timer = @
    timerId = window.setInterval(->
      timer.timerUpdate()
    , 1000)
    @set({timerId: timerId})
  initialize = ->    
  String::pad = (l, s) ->
    (if (l -= @length) > 0 then (s = new Array(Math.ceil(l / s.length) + 1).join(s)).substr(0, s.length) + this + s.substr(0, l - s.length) else this)

jQuery ->
  @app = window.app ? {}
  @app.Timer = Timer