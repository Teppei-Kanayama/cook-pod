class DishesController < ApplicationController
  def index
    @dishes = []
    Dish.all.reverse_each do |dish|
      dish_id = dish.id
      last_image_filename = DishImage.where(dish_id: dish_id).to_ary()[-1]
      dish_dict = {id: dish_id, name: dish.name, url: dish.url, memo: dish.memo, image: last_image_filename}
      @dishes.append dish_dict
    end
  end
  
  def show
    dish_id = params[:id]
    @dish = Dish.find(dish_id)
    @dish_images = DishImage.where(dish_id: dish_id).to_ary()
    
  end
  
  def new
    @dish  = Dish.new
  end
  
  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      render 'index'
    else
      # TODO: エラーメッセージ
      render 'new'
    end
  end
  
  private

    # マスアサインメント対策
    def dish_params
      params.require(:dish).permit(:name, :url, :memo)
    end
end
