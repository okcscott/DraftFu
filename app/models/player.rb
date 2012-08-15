class Player < ActiveRecord::Base
  has_many :draftPicks
  has_many :teams, :through => :draftPicks
  has_many :leagues, through: :teams

  default_scope order(:rank)
  scope :exclude, lambda {|players| where("id NOT IN (?)", players) unless players.empty?}
end
