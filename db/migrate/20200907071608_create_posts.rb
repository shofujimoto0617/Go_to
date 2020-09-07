class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :cuntry, null: false, default: ""
      t.string :place, null: false, default: ""
      t.text :body
      t.integer :price
      t.timestamps
    end
  end
end
