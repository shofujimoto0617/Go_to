class RenameCuntryColumnToPosts < ActiveRecord::Migration[5.2]
  def change
  	rename_column :posts, :cuntry, :country
  end
end
