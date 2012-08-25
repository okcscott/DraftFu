class AddStatsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :win_pct, :string
    add_column :teams, :championships, :string
    add_column :teams, :avg_place, :string
  end
end
