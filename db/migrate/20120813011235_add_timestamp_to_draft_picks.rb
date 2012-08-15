class AddTimestampToDraftPicks < ActiveRecord::Migration
  def change
    add_column :draft_picks, :timestamp, :datetime
  end
end
