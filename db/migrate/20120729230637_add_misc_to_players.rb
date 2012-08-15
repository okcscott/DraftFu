class AddMiscToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :bye_week, :integer
    add_column :players, :team, :string
    add_column :players, :image_url, :string
  end
end
