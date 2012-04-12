class AddSettingsToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :roster_spots, :integer
    add_column :leagues, :starting_qb, :integer
    add_column :leagues, :starting_wr, :integer
    add_column :leagues, :starting_rb, :integer
    add_column :leagues, :starting_te, :integer
    add_column :leagues, :starting_k, :integer
    add_column :leagues, :starting_def, :integer
  end
end
