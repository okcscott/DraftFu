class DropTeamsPlayers < ActiveRecord::Migration
  def up
    drop_table :teams_players
  end

  def down
  end
end
