class AddMissedToDraftPick < ActiveRecord::Migration
  def change
    add_column :draft_picks, :missed, :boolean, default: false
    add_column :draft_picks, :league_id, :integer
  end
end
