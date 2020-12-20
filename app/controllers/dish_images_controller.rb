class DishImagesController < ApplicationController
  def new
    @dish_image = DishImage.new
  end
  
  def create
  end
end
