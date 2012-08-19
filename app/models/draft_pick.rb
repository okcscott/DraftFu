class DraftPick < ActiveRecord::Base
  belongs_to :player
  belongs_to :team
  default_scope order("draft_picks.round, draft_picks.pick")
  scope :missed, where(missed: true)
  scope :available, where(player_id: nil)
end
