class DraftFu.Views.AvailablePlayersView extends Backbone.View
  template: JST["available_players"]

  initialize: ->

  render: (availablePlayers, currentTeam) ->
    console.log currentTeam
    @template(availablePlayers: availablePlayers, currentTeam: currentTeam)
