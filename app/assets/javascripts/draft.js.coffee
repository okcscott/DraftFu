# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
  $('.draft_player').click ->
    console.log("Player Id: #{$(@).data('player')} | Team Id: #{$(@).data('team')}");
    $.ajax
      type: "POST"
      url: "/draft/player"
      data: {player_id : $(@).data('player'), team_id : $(@).data('team')}
      success: (data, textStatus, jqXHR) ->
        console.log data
      error: (jqXHR, status, errorThrown) ->
        console.log jqXHR.status
      dataType: "json"