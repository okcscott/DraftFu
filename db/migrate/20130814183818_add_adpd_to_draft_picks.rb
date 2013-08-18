class AddAdpdToDraftPicks < ActiveRecord::Migration
  def change
    add_column :draft_picks, :adpd, :decimal
  end
end
