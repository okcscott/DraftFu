class Players extends Backbone.Collection
  model: app.Player
  initialize: (models, options) ->
    @league_id = options.league_id
  url: ->
    "/api/players/available.json?league_id=#{@league_id}"
jQuery ->
  @app = window.app ? {}
  @app.Players = new Players([],
    league_id : $('#league_id').val()
  )
