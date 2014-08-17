class DraftFu.Models.Roster extends Backbone.Model
  grade: ->
    picked_players = _.filter @.get("draftPicks"), (draftPick) ->
      draftPick.player_id?

    adpd_total = 0
    for draftPick in picked_players
      adpd_total += parseInt(draftPick.adpd)

    adpd_average = (adpd_total/picked_players.length)

    final_grade = switch
      when (adpd_average < 1) then "a"
      when (adpd_average < 2) then "b"
      when (adpd_average < 3) then "c"
      when (adpd_average < 4) then "d"
      else "f"

    final_grade