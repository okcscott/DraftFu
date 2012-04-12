class DraftPick < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  has_one :league, through: :team
end
