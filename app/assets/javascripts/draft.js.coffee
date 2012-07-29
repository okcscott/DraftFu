# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
  $('.draft_player').live 'click', ->
    console.log("Player Id: #{$(@).data('player')} | Team Id: #{$(@).data('team')}");
    $.ajax
      type: "POST"
      url: "/api/players/draft"
      data: {player_id : $(@).data('player'), team_id : $(@).data('team'), league_id : "#{GetLeagueId()}"}
      success: (data, textStatus, jqXHR) ->
        console.log data
        $.when(GetCurrentPick()).then(ReloadPlayers())
      error: (jqXHR, status, errorThrown) ->
        console.log jqXHR.status
      dataType: "json"
  GetLeagueId = ->
    return $('#league_id').val()
  GetTeamId = ->
    return $('#team_id').val()
  GetCurrentPick = ->
    $.getJSON "/api/leagues/current_pick.json?league_id=#{GetLeagueId()}", (data) ->
      $('#round').val(data.round)
      $('#pick').val(data.pick)
      $('#team_id').val(data.team_id)
  ReloadPlayers = ->
    $('#player_list .players').html("")
    $.getJSON "/api/players/available.json?league_id=#{GetLeagueId()}&count=20", (data) ->
      for player in data
        content = "<div class='player'>"
        content += "<span><b>#{player.rank}</b></span>"
        content += "<span>#{player.name}</span>"
        content += "<a href='javascript:void(0)' class='draft_player' data-player='#{player.id}' data-team='#{GetTeamId()}'>draft</a>"
        content += "</div>"
        $('#player_list .players').append(content)

  $.when(GetCurrentPick()).then(ReloadPlayers())