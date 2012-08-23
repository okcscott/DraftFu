# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

bye_weeks = {
        "IND" => 4,
        "PIT" => 4,
        "DAL" => 5,
        "DET" => 5,
        "OAK" => 5,
        "TB" => 5,
        "CAR" => 6,
        "CHI" => 6,
        "JAC" => 6,
        "NO" => 6,
        "ATL" => 7,
        "DEN" => 7,
        "KC" => 7,
        "MIA" => 7,
        "PHI" => 7,
        "SD" => 7,
        "BAL" => 8,
        "BUF" => 8,
        "CIN" => 8,
        "HOU" => 8,
        "NE" => 9,
        "NYJ" => 9,
        "SF" => 9,
        "STL" => 9,
        "ARI" => 10,
        "CLE" => 10,
        "GB" => 10,
        "WAS" => 10,
        "MIN" => 11,
        "NYG" => 11,
        "SEA" => 11,
        "TEN" => 11 }

Player.where(:bye_week => nil).each do |player|
  player.bye_week = bye_weeks[player.team.upcase]
  player.save
end

# Player.where(:image_url => nil, :position => "DEF").each do |player|
#   if player.yahooid.length > 2
#     player.image_url = "http://l.yimg.com/a/i/us/sp/v/nfl/teams/1/50x50w/#{player.yahooid}.gif"
#   end
#   player.save
# end