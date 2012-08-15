class DraftPick extends Backbone.Model
  url: ->
    "/api/leagues/current_pick.json?league_id=#{@get('league_id')}"
jQuery ->
  @app = window.app ? {}
  @app.DraftPick = new DraftPick
    league_id: $('#league_id').val()