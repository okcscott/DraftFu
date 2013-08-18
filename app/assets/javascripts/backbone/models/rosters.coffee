class DraftFu.Collections.Rosters extends Backbone.Collection
  model: DraftFu.Models.Roster
  initialize: (models, options) ->
    @league_id = options.league_id
  url: ->
    "/api/leagues/picks_queue.json?league_id=#{@league_id}"