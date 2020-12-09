class DishesController < ApplicationController
  def index
    @dishes = Dish.all
  end
  
  def show
    @dish = Dish.find(params[:id])
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def delete
  end
end
