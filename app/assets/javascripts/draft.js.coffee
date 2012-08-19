# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->

  pusher = new Pusher($('meta[name="pusher-key"]').attr('content'))
  channel = pusher.subscribe('draft')

  if $('#draft_view').val()

    channel.bind 'pick_made', (data) ->  
      view = new window.app.PickMadeView
        model: jQuery.parseJSON(data.message.player)
        team: jQuery.parseJSON(data.message.team)
      view.render()
      
      setTimeout (->
        view.hide()
      ), 3000

      app.LeagueInfo.fetch()

    channel.bind 'pick_missed', (data) -> 
      view = new window.app.PickMissedView
        team_name: data.message.team.name 
      view.render()
      
      setTimeout (->
        view.hide()
      ), 3000

      app.LeagueInfo.fetch()

    channel.bind 'pause', (data) -> 
      app.LeagueInfo.fetch()
      console.log "pause"

    channel.bind 'resume', (data) -> 
      app.LeagueInfo.fetch()
      console.log "pause"



