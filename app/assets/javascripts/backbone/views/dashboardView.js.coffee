class DraftFu.Views.DashboardView extends Backbone.View
  el: "#dashboard"
  template: JST["dashboard"]

  initialize: (current_pick)->
    @current_pick = current_pick

  render: ->
    $(@el).html @template(@)
    @drawByeWeeks()
    @drawRoster()
    @setAnimation()
    @resizeText()
    @

  update: (current_pick)->
    @current_pick = current_pick
    @render()

  resizeText: ->
    championships = $(@el).find('.championships span')
    grade = $(@el).find('.grade span')
    c_height = championships.height()
    g_height = grade.height()
    font_size = 50

    loop
      championships.css('font-size', font_size)
      c_height = championships.height()
      font_size = font_size - 1
      break unless c_height > g_height

  setAnimation: ->
    self = @el

    setTimeout (->
      $(self).css('opacity','1')
      return
    ), 3000

    setTimeout (->
      $(self).css('opacity','0')
      return
    ), 10000

  drawRoster: ->
    rosterCount = {"QB": 0, "RB": 0, "WR": 0, "TE": 0, "PK": 0, "DEF": 0}

    for draftPick in @current_pick.team.draftPicks
      rosterCount[draftPick.player.position]++ if draftPick.player_id != null

    data = google.visualization.arrayToDataTable([
      ['Position', 'Roster Spots'],
      ['QB', rosterCount["QB"]],
      ['RB', rosterCount["RB"]],
      ['WR', rosterCount["WR"]],
      ['TE', rosterCount["TE"]],
      ['PK', rosterCount["PK"]],
      ['DEF', rosterCount["DEF"]]
    ])

    options =
      pieHole: 0.5,
      legend: "none",
      pieSliceText: "label",
      theme: "maximized"
      slices:
        0:
          color: '#105563',
        1:
          color: '#19889e',
        2:
          color: '#23bad8',
        3:
          color: '#5acee5',
        4:
          color: '#95dfee',
        5:
          color: '#cff1f7',

    chart = new google.visualization.PieChart(document.getElementById('positions'))
    chart.draw(data, options)

  drawByeWeeks: ->
    byeWeeksCount = {"4": 0, "5": 0, "6": 0, "7": 0, "8": 0, "9": 0, "10": 0, "11": 0, "12": 0}

    for draftPick in @current_pick.team.draftPicks
      byeWeeksCount[draftPick.player.bye_week]++ if draftPick.player_id != null

    data = google.visualization.arrayToDataTable([
      ["Week", "Players"]
      ["4", byeWeeksCount["4"]]
      ["5", byeWeeksCount["5"]]
      ["6", byeWeeksCount["6"]]
      ["7", byeWeeksCount["7"]]
      ["8", byeWeeksCount["8"]]
      ["9", byeWeeksCount["9"]]
      ["10", byeWeeksCount["10"]]
      ["11", byeWeeksCount["11"]]
      ["12", byeWeeksCount["12"]]
    ])
    options =
      colors: ["#F38630"]
      legend: "none"
      backgroundColor: "transparent"
      theme: "maximized"
      hAxis:
        ticks: [5,10,20]
      series:
        0:
          textStyle:
            color: "#fff"
      titleTextStyle:
        color: "#fff"


    chart = new google.visualization.ColumnChart(document.getElementById("bye-weeks"))
    chart.draw data, options

  grade: ->

    adpd_total = 0
    picked_players = 0
    for draftPick in @current_pick.team.draftPicks
      if draftPick.player_id != null
        adpd_total += parseInt(draftPick.adpd)
        picked_players++

    adpd_average = (adpd_total/picked_players)

    final_grade = switch
      when (adpd_average < 1) then "A"
      when (adpd_average < 2) then "B"
      when (adpd_average < 3) then "C"
      when (adpd_average < 4) then "D"
      else "F"

    final_grade