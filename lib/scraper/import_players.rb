#!/usr/bin/env ruby 
require "rubygems"
require "bundler/setup"
require "capybara"
require "capybara/dsl"
require "capybara-webkit"
# require "~/config/environment.rb"
# Capybara.run_server = true
Capybara.current_driver = :webkit
Capybara.app_host = "http://www.yahoo.com/"

module ImportPlayers
  class Yahoo
    include Capybara::DSL
    
    def get_results
      # visit("http://fantasynews.cbssports.com/fantasyfootball/rankings/top200")
      visit("http://football.fantasysports.yahoo.com/f1/174638/players")
      fill_in('username', :with => 'dajukie7')
      fill_in('passwd', with: "6403astbous3")
      click_on('Sign In')
      puts "Finding Players"
      wait_until { page.find(".players").visible? }
      puts "Found Em"
      i = 0
      while true
        current_url = page.current_url
        all(:css, ".players tr.odd, .players tr.even").each do |player_row|
          #player name
          player_link = player_row.find(:css, ".player a")
          yahoo_id = player_link[:href].split("/").last
          player_name = player_link.text

          #team / position
          player_detail = player_row.find(:css, ".player .detail span").text.delete("() ").split("-")
          team = player_detail[0]
          position = player_detail[1]

          #rank
          rank = player_row.find(:css, ".stat").text
          player = Player.new(name: player_name, yahooid: yahoo_id, position: position, rank: rank, team: team)
          player.save
          i = i+1
        end 
        
        if has_css?(".pagingnavlist .last a") && i < 500
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
      visit("http://football.fantasysports.yahoo.com/f1/174638/players?&sort=PR&sdir=1&status=A&pos=K&stat1=S_S_2011&jsenabled=1")
      fill_in('username', :with => 'dajukie7')
      fill_in('passwd', with: "6403astbous3")
      click_on('Sign In')
      puts "Finding Players"
      wait_until { page.find(".players").visible? }
      puts "Found Em"
      i = 0
      while true
        current_url = page.current_url
        all(:css, ".players tr.odd, .players tr.even").each do |player_row|
          #player name
          player_link = player_row.find(:css, ".player a")
          yahoo_id = player_link[:href].split("/").last
          player_name = player_link.text

          #team / position
          player_detail = player_row.find(:css, ".player .detail span").text.delete("() ").split("-")
          team = player_detail[0]
          position = player_detail[1]

          #rank
          rank = player_row.find(:css, ".stat").text
          player = Player.new(name: player_name, yahooid: yahoo_id, position: position, rank: rank, team: team)
          player.save
          i = i+1
        end 
        
        if has_css?(".pagingnavlist .last a") && i < 500
          puts "Going to next page"
          click_link("Next 25")
          sleep(2)
          puts "On the next page?"
        else
          break
        end
      end
    end

    def get_def
      visit("http://football.fantasysports.yahoo.com/f1/174638/players?&sort=PR&sdir=1&status=A&pos=DEF&stat1=S_S_2011&jsenabled=1")
      fill_in('username', :with => 'dajukie7')
      fill_in('passwd', with: "6403astbous3")
      click_on('Sign In')
      puts "Finding Players"
      wait_until { page.find(".players").visible? }
      puts "Found Em"
      i = 0
      while true
        current_url = page.current_url
        all(:css, ".players tr.odd, .players tr.even").each do |player_row|
          #player name
          player_link = player_row.find(:css, ".player a")
          yahoo_id = player_link[:href].split("/").last
          player_name = player_link.text

          #team / position
          player_detail = player_row.find(:css, ".player .detail span").text.delete("() ").split("-")
          team = player_detail[0]
          position = player_detail[1]

          #rank
          rank = player_row.find(:css, ".stat").text
          player = Player.new(name: player_name, yahooid: yahoo_id, position: position, rank: rank, team: team)
          puts "#{player.name} #{player.position}"
          player.save
          i = i+1
        end 
        
        if has_css?(".pagingnavlist .last a") && i < 500
          puts "Going to next page"
          click_link("Next 25")
          sleep(2)
          puts "On the next page?"
        else
          break
        end
      end
    end

    def get_images
      Player.where(:image_url => nil).each do |player|
        visit("http://sports.yahoo.com/nfl/players/#{player.yahooid}")
        player_image = find(".nfl-player-nav img")[:src]
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
  end
end

# spider = ImportPlayers::Yahoo.new
# spider.get_results