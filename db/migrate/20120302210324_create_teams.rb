class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.references :league

      t.timestamps
    end
    add_index :teams, :league_id
  end
end
