require 'spec_helper'

describe "Leagues" do
  before do
    @league = FactoryGirl.create :league_with_teams
    @players = FactoryGirl.create_list(:player, 60)
  end 
  
  def simulate_picks_until(round, pick) 
    pick_total = (@league.teams.length * (round - 1)) + (pick - 1)
    (0...pick_total).each do |pick|
      @league.make_pick(@league.current_team.id, @players[pick].id)
    end
    @league.save
  end
    
  # describe "valid pick" do
  #   it "should make the pick if it is the current team" do
  #     pick = @league.make_pick(@league.teams.first.id, @players.first.id)
  #     pick.player_id.should eq(@players.first.id)
  #   end
  #   
  #   it "should move to the next pick" do
  #     pick = @league.make_pick(@league.teams.first.id, @players.first.id)
  #     @league.current_pick.pick.should eq 2
  #   end
  # end
  
  describe "invalid pick" do
    # it "should not make the pick if it is not the current team" do
    #   pick = @league.make_pick(@league.teams.second.id, @players.first.id)
    #   pick.player_id.should be_nil
    # end
    
    it "should not make the pick if the player has already been drafted" do
      # simulate_picks_until(1,2)
      # pick = League.first.make_pick(@league.teams.second.id, @players.first.id)
      simulate_picks_until(1,2)
      @league.reload
      pick = @league.make_pick(@league.teams.second.id, @players.first.id)
      pick.player_id.should be_nil
    end
  end
  
  # describe "end of the round" do
  #   it "should move to the next round" do
  #     simulate_picks_until(2,1)
  #     @league.current_pick.round.should eq 2
  #     @league.current_pick.pick.should eq 1
  #   end
  # end
  # 
  # describe ".current_pick" do
  #   it "should be round 1 pick 1 at the beginning" do
  #     @league.current_pick.round.should eq(1)
  #     @league.current_pick.pick.should eq(1)
  #   end
  # end
end