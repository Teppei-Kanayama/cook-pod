class FixTypoInDishImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :dish_images, :imega_id, :integer
    add_column :dish_images, :dish_id, :integer
  end
end
