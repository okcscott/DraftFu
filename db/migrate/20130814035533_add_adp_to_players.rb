class AddAdpToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :adp, :decimal
  end
end
