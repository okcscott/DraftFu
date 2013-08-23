class DraftFu.Views.AvailablePlayersView extends Backbone.View
  template: JST["available_players"]

  initialize: ->

  render: (availablePlayers, currentTeam) ->
    @template(availablePlayers: availablePlayers, currentTeam: currentTeam)
