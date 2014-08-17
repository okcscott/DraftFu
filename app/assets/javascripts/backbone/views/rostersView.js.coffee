class DraftFu.Views.RostersView extends Backbone.View
  template: JST["rosters"]
  el: "#rosters"

  initialize: (rosters, current_pick) ->
    @rosters = new DraftFu.Collections.Rosters(rosters)
    @current_pick = current_pick

  render: ->
    @$el.html(@template(@))

  isActive: (draftPick) ->
    if ((draftPick.round == @current_pick.round) and (draftPick.pick == @current_pick.pick)) then "active" else ""

  isMissed: (draftPick) ->
    if draftPick.missed then "missed" else ""

  update: (rosters, current_pick) ->
    @rosters = new DraftFu.Collections.Rosters(rosters)
    @current_pick = current_pick
    @render()

  grade: (draftPick) ->
    final_grade = switch
      when (draftPick.adpd < 1) then "a"
      when (draftPick.adpd < 2) then "b"
      when (draftPick.adpd < 3) then "c"
      when (draftPick.adpd < 4) then "d"
      else "f"

    final_grade