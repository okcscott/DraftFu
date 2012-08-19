class AddPauseToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :pause, :boolean, default: true
  end
end
