class AddPickToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :pick, :integer
  end
end
