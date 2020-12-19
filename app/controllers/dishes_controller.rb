class DishesController < ApplicationController
  def index
    @dishes = Dish.all
  end
  
  def show
    @dish = Dish.find(params[:id])
  end
  
  def new
    @dish  = Dish.new
  end
  
  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      render 'index'
    else
      render 'new'
    end
  end
  
  private

    # マスアサインメント対策
    def dish_params
      params.require(:dish).permit(:name, :url, :memo)
    end
end
