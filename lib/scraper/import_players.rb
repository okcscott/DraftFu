#!/usr/bin/env ruby 
require "rubygems"
require "bundler/setup"
require "capybara"
require "capybara/dsl"
require "capybara-webkit"
# require "~/config/environment.rb"
Capybara.run_server = false
Capybara.current_driver = :webkit
Capybara.app_host = "http://www.yahoo.com/"

module ImportPlayers
  class Yahoo
    include Capybara::DSL
    
    def get_results
      # visit("http://fantasynews.cbssports.com/fantasyfootball/rankings/top200")
      #       rank = 1
      #       
      #       all(:css, "tr.row1 td, tr.row2 td").each do |element|
      #         if element.text.to_i != 0
      #           rank = element.text          
      #         else
      #           yahooid = element.find(:css, "a")[:href].split("/")[4]
      #           element_text = element.text.gsub(",","").split(" ")
      #           
      #           player = Player.where("name = '#{element_text[1]} #{element_text[0]}'").first
      #           if !player
      #             player = Player.new(name: "#{element_text[1]} #{element_text[0]}", position: element_text[2], yahooid: yahooid, rank: rank, )
      #             player.save
      #           end          
      #         end
      #       end   
      #     end
  end
end

spider = ImportPlayers::Yahoo.new
spider.get_results