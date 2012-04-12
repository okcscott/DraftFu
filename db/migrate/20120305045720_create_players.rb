class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.string :yahooid
      t.integer :rank

      t.timestamps
    end
    
    create_table :teams_players, :id => false do |t|
      t.references :team, :player
    end

    add_index :teams_players, [:team_id, :player_id]
  end
end
