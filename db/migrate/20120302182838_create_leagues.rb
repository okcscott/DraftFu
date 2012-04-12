class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.references :commissioner

      t.timestamps
    end
    add_index :leagues, :commissioner_id
  end
end
