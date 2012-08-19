class DraftPicks extends Backbone.Collection
  model: app.DraftPick
  initialize: (models, options) ->
    @team_id = options.team_id
  url: ->
    "/api/teams/draft_picks.json?team_id=#{@team_id}"
  
@app = window.app ? {}
@app.DraftPicks = DraftPicks
