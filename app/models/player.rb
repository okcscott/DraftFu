class Player < ActiveRecord::Base
  has_many :draftPicks
  has_many :teams, :through => :draftPicks
  has_many :leagues, through: :teams
end
