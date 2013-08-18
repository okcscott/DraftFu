#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "capybara"
require "capybara/dsl"
require "capybara-webkit"
# require "~/config/environment.rb"
# Capybara.run_server = true
# Capybara.current_driver = :webkit
Capybara.current_driver = :selenium
Capybara.app_host = "http://www.yahoo.com/"

LEAGUE_ID = 101827

module ImportPlayers
  class Yahoo
    include Capybara::DSL

    def get_players
      # visit("http://fantasynews.cbssports.com/fantasyfootball/rankings/top200")
      # visit("http://football.fantasysports.yahoo.com/f1/124188/players") sammy
      # visit("http://football.fantasysports.yahoo.com/f1/#{LEAGUE_ID}/players")
      visit("http://football.fantasysports.yahoo.com/f1/#{LEAGUE_ID}/players?&sort=PR&sdir=1&status=A&pos=K&stat1=S_S_2012&jsenabled=1")
      fill_in('username', :with => 'dajukie7')
      fill_in('passwd', with: '8640H1llv13w')
      click_on('.save')
      puts "Finding Players"
      page.find(".teamtable").visible?
      puts "Found Em"
      i = 0
      while true
        current_url = page.current_url
        all(:css, ".teamtable tr.odd, .teamtable tr.even").each do |player_row|
          player_link = player_row.find(:css, ".player a.name")
          yahoo_id = player_link[:href].split("/").last
          unless Player.exists?(yahooid: yahoo_id)

            #player name
            player_link = player_row.find(:css, ".player a.name")
            yahoo_id = player_link[:href].split("/").last
            player_name = player_link.text
            puts "New player #{player_name} was found."

            #team / position
            player_detail = player_row.find(:css, ".player .ysf-player-team-pos").text.delete("() ").split("-")
            team = player_detail[0]
            position = player_detail[1]

            #rank
            rank = player_row.find(:css, ".stat.wide.sorted").text
            player = Player.new(name: player_name, yahooid: yahoo_id, position: position, rank: rank, team: team)
            player.save
            i = i+1
            puts "#{i} new players were saved to DB."
          end
        end

        if has_css?(".pagingnavlist .last a")
          puts "Going to next page"
          click_link("Next 25")
          sleep(2)
          puts "On the next page?"
        else
          break
        end
      end
    end

    def get_kickers
      visit("http://football.fantasysports.yahoo.com/f1/#{LEAGUE_ID}/players?&sort=PR&sdir=1&status=A&pos=K&stat1=S_S_2012&jsenabled=1")
    #  fill_in('username', :with => 'mxstrand')
    #  fill_in('passwd', with: "houseboat")
    #  click_on('Sign In')
      puts "Finding Kickers"
      page.find(".teamtable").visible?
      # wait_until { page.find(".players").visible? } old capybara syntax
      puts "Found Em"
      i = 0
      while true
        current_url = page.current_url
        all(:css, ".teamtable tr.odd, .teamtable tr.even").each do |player_row|
          player_link = player_row.find(:css, ".player a.name")
          yahoo_id = player_link[:href].split("/").last
          unless Player.exists?(yahooid: yahoo_id)

            #player name
            player_link = player_row.find(:css, ".player a.name")
            yahoo_id = player_link[:href].split("/").last
            player_name = player_link.text

            #team / position
            player_detail = player_row.find(:css, ".player .ysf-player-team-pos").text.delete("() ").split("-")
            team = player_detail[0]
            position = player_detail[1]

            #rank
            rank = player_row.find(:css, ".stat.wide.sorted").text
            player = Player.new(name: player_name, yahooid: yahoo_id, position: position, rank: rank, team: team)
            player.save
            i = i+1
            puts "#{i} new kickers were saved to DB."
          end
        end

        if has_css?(".pagingnavlist .last a") && i < 500
          puts "Going to next page"
          # click_link("Next 25") old capybara syntax
          first(:link, 'Next 25').click
          sleep(2)
          puts "On the next page?"
        else
          break
        end
      end
    end

    def get_def
      visit("http://football.fantasysports.yahoo.com/f1/#{LEAGUE_ID}/players?&sort=PR&sdir=1&status=A&pos=DEF&stat1=S_S_2011&jsenabled=1")
    #  fill_in('username', :with => 'mxstrand')
    #  fill_in('passwd', with: "houseboat")
    #  click_on('Sign In')
      fill_in('username', :with => 'dajukie7')
      fill_in('passwd', with: '8640H1llv13w')
      click_on('.save')
      puts "Finding Defenses"
      # wait_until { page.find(".players").visible? } old capybara syntax
      page.find(".teamtable").visible?
      puts "Found Em"
      i = 0
      while true
        current_url = page.current_url
        all(:css, ".teamtable tr.odd, .teamtable tr.even").each do |player_row|
          player_link = player_row.find(:css, ".player a.name")
          yahoo_id = player_link[:href].split("/").last
          unless Player.exists?(yahooid: yahoo_id)

            #player name
            player_link = player_row.find(:css, ".player a.name")
            yahoo_id = player_link[:href].split("/").last
            player_name = player_link.text

            #team / position
            player_detail = player_row.find(:css, ".player .ysf-player-team-pos").text.delete("() ").split("-")
            team = player_detail[0]
            position = player_detail[1]

            #rank
            rank = player_row.find(:css, ".stat.wide.sorted").text
            player = Player.new(name: player_name, yahooid: yahoo_id, position: position, rank: rank, team: team)
            puts "#{player.name} #{player.position}"
            player.save
            i = i+1
            puts "#{i} new defenses were saved to DB."
          end
        end

        if has_css?(".pagingnavlist .last a") && i < 500
          puts "Going to next page"
          click_link("Next 25")
          # first(:link, 'Next 25').click
          sleep(2)
          puts "On the next page?"
        else
          break
        end
      end
    end

    def get_player_images
      Player.where("image_url IS NULL AND position != 'DEF'").each do |player|
        puts "#{player.name} : #{player.yahooid}"
        visit("http://sports.yahoo.com/nfl/players/#{player.yahooid}")
        player_image = find("#player-header .bd img")[:src]
        temp_image = player_image.split("/http:")
        if temp_image.count == 1
          #team logo, just set, no need to parse
          player.image_url = temp_image[0]
        else
          player.image_url = "http:" + temp_image[1]
        end
        player.save
      end
    end

    def get_team_images
      Player.where("image_url IS NULL AND position = 'DEF'").each do |player|
        puts "#{player.name} : #{player.yahooid}"
        visit("http://sports.yahoo.com/nfl/teams/#{player.yahooid}")
        team_image = find(".this-team .logo img")[:src]
        temp_image = team_image.split("/http:")
        if temp_image.count == 1
          #team logo, just set, no need to parse
          player.image_url = temp_image[0]
        else
          player.image_url = "http:" + temp_image[1]
        end
        player.save
      end
    end
  end
end

# spider = ImportPlayers::Yahoo.new
# spider.get_players