class Team < ActiveRecord::Base
  belongs_to :league
  has_many :draftPicks
  has_many :players, :through => :draftPicks
  
  validates_presence_of :name
end
