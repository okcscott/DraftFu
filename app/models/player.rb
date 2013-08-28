class Player < ActiveRecord::Base
  has_many :draftPicks
  has_many :teams, :through => :draftPicks
  has_many :leagues, through: :teams

  default_scope order(:adp)
  scope :exclude, lambda {|players| where("id NOT IN (?)", players) unless players.empty?}

  def self.available_for_league(league_id)
    joins("LEFT OUTER JOIN draft_picks ON (draft_picks.player_id = players.id and draft_picks.league_id = #{league_id})").where("draft_picks.player_id IS NULL").order(:adp)
  end
end
