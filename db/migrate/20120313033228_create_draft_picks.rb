class CreateDraftPicks < ActiveRecord::Migration
  def change
    create_table :draft_picks do |t|
      t.integer :round
      t.integer :pick
      t.references :player
      t.references :team

      t.timestamps
    end
    add_index :draft_picks, :player_id
    add_index :draft_picks, :team_id
  end
end
