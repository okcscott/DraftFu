#http://football.myfantasyleague.com/2013/export
namespace :my_fantasy_league do
  desc "Import players from MyFantasyLeague"
  task :import_players => :environment do
		valid_positions = ["DEF","QB","RB","WR","TE","K"]
		response = HTTParty.get("http://football.myfantasyleague.com/2013/export?TYPE=players&L=&W=&JSON=1")
		response["players"]["player"].each do |player|
			if (valid_positions.include? player["position"]) and (!Player.exists?(yahooid: player["id"]))
				Player.create(name: player["name"], yahooid: player["id"], team: player["team"], position: player["position"])
			end
		end
  end

  desc "Update ADP from MyFantasyLeague"
  task :update_adp => :environment do
		response = HTTParty.get("http://football.myfantasyleague.com/2013/export?TYPE=adp&L=&W=&JSON=1")
		response["adp"]["player"].each do |player|
			database_player = Player.find_by_yahooid(player["id"])
			database_player.update_attributes(adp: player["averagePick"]) if database_player
		end
  end

	desc "Set Bye Weeks"
  task :set_bye_weeks => :environment do
		bye_weeks = Hashie::Mash.new(YAML.load(File.read("#{Rails.root}/lib/bye_weeks.yml")))
		bye_weeks.teams.each do |team|
			Player.where(team: team.name).update_all(bye_week: team.bye_week)
		end
  end
  
end