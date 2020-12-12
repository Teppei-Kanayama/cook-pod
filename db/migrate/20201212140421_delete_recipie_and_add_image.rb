class DeleteRecipieAndAddImage < ActiveRecord::Migration[5.1]
  def change
    remove_column :dishes, :recipe, :string
  end
end
