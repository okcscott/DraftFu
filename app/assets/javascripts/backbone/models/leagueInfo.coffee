class LeagueInfo extends Backbone.Model
  url: ->
    "/api/leagues/current_pick.json?league_id=#{@get('league_id')}"
jQuery ->
  @app = window.app ? {}
  @app.LeagueInfo = new LeagueInfo
    league_id: $('#league_id').val()