class AddSlugToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :slug, :string
  end
end
