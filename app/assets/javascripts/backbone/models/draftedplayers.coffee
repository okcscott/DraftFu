class DraftedPlayers extends Backbone.Collection
  model: app.Player
  initialize: (models, options) ->
    @team_id = options.team_id
  url: ->
    "/api/players/drafted.json?team_id=#{$('#team_id').val()}"
jQuery ->
  @app = window.app ? {}
  @app.DraftedPlayers = new DraftedPlayers([],
    team_id : $('#team_id').val()
  )
