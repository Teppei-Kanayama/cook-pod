class DishesController < ApplicationController
  def index
    @dishes = Dish.all
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
