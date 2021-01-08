module DishesHelper
	def get_index_dishes
		dishes = []
    Dish.all.reverse_each do |dish|
      dish_id = dish.id
      last_image_filename = DishImage.where(dish_id: dish_id).to_ary()[-1]  # TODO: 料理数と同じ回数のrequestが発生するので遅い
      dish_dict = {id: dish_id, name: dish.name, url: dish.url, memo: dish.memo, image: last_image_filename}
      dishes.append dish_dict
     end
    return dishes
	end
end
