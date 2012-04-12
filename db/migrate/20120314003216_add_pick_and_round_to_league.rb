class AddPickAndRoundToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :pick, :integer, default: 1
    add_column :leagues, :round, :integer, default: 1
  end
end
