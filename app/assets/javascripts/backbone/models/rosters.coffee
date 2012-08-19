class Rosters extends Backbone.Collection
  model: app.Roster
  initialize: (models, options) ->
    @league_id = options.league_id
  url: ->
    "/api/leagues/picks_queue.json?league_id=#{@league_id}"

@app = window.app ? {}
@app.Rosters = Rosters