class DraftFu.Views.LeagueInfoView extends Backbone.View
  el: "#league_info"
  template: JST["league_info"]
  initialize: ->
  render: ->    
    $(@el).html @template(@model.toJSON())
    @trigger("leagueInfoUpdated")
    @