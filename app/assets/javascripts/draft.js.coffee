# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->

  pusher = new Pusher($('meta[name="pusher-key"]').attr('content'))
  channel = pusher.subscribe('draft')

  DraftFu.Mediator = new Mediator()

  playMusic = ->
    if $('audio').length > 0
      $('audio')[0].play()

  channel.bind 'pick_made', (data) ->
    DraftFu.Mediator.publish("pick:made", jQuery.parseJSON(data.draftPick))
    playMusic()

  channel.bind 'pick_missed', (data) -> 
    DraftFu.Mediator.publish("pick:missed")
    playMusic()

  channel.bind 'pause', (data) -> 
    DraftFu.Mediator.publish("draft:pause")
    playMusic()

  channel.bind 'resume', (data) -> 
    DraftFu.Mediator.publish("draft:resume", jQuery.parseJSON(data.currentPick))
    playMusic()

  channel.bind 'end_draft', (data) -> 
    console.log "draft is over"
    DraftFu.Mediator.publish("draft:end")
    playMusic()

  # if $('#draft_view').val()

    # channel.bind 'pick_made', (data) ->  

    #   DraftFu.Mediator.publish("pick:made", data)

      # view = new window.app.PickMadeView
      #   model: jQuery.parseJSON(data.message.player)
      #   team: jQuery.parseJSON(data.message.team)
      # view.render()

      # playMusic()

      # app.LeagueInfo.fetch()

    





