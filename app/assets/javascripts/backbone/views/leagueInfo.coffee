jQuery ->
  class LeagueInfoView extends Backbone.View
    el: "#league_info"
    template: _.template($('#league_info_template').html())
    initialize: ->
    render: ->    
      $(@el).html @template(@model.toJSON())
      @trigger("leagueInfoUpdated")
      @
  @app = window.app ? {}
  @app.LeagueInfoView = LeagueInfoView