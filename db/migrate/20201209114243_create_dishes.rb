class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :recipe
      t.string :url
      t.string :memo

      t.timestamps
    end
  end
end
