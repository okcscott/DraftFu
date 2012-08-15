class League < ActiveRecord::Base
  belongs_to :commissioner, :class_name => "User"
  has_many :teams, order: "pick ASC"
  has_many :draftPicks, through: :teams
  has_many :players, through: :draftPicks
  
  validates_presence_of :name
  
  def available_players
    player_ids = self.players.map(&:id)
    Player.exclude(player_ids)
  end
  
  def current_pick
    #check the leagues current round and pick
    #if there is no draft pick for that slot
    #create one (new pick) otherwise, return it
    self.draftPicks.where(round: self.round, pick: self.pick).first || current_team.draftPicks.create(round: self.round, pick: self.pick, timestamp: Time.now)
  end
  
  def current_team
    index = self.round.odd? ? (self.pick - 1) : (self.pick - self.teams.count).abs
    self.teams[index]
  end
  
  def move_to_the_next_pick
    #check if it is the end of the round
    if self.pick == teams.count
      self.round += 1
      self.pick = 1
    else
      self.pick += 1
    end
    self
  end

  def player_available(player_id)
    self.available_players.any? {|x| x[:id] == player_id}
  end
  
  def make_pick(team_id, player_id)
    pick = self.current_pick
    #make sure the current team is making the pick
    if (team_id == pick.team.id) && self.available_players.any? {|x| x[:id] == player_id}
      pick.player_id = player_id
      self.current_team.draftPicks << pick
      self.move_to_the_next_pick
    end
    pick  
  end

  def to_param
    "#{slug}"
  end
end
