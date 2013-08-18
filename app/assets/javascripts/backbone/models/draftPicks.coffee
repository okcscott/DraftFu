class DraftFu.Collections.DraftPicks extends Backbone.Collection
  model: DraftFu.Models.DraftPick
  initialize: (models, options) ->
    @team_id = options.team_id
  url: ->
    "/api/teams/draft_picks.json?team_id=#{@team_id}"