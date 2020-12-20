class CreateDishImages < ActiveRecord::Migration[5.1]
  def change
    create_table :dish_images do |t|
      t.integer :imega_id
      t.string :filename

      t.timestamps
    end
  end
end
