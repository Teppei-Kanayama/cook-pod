class DishImagesController < ApplicationController
  def new
    @dish_image = DishImage.new
  end
  
  def create
    dish_id = params[:dish_image][:dish_id]
    filename = ('a'..'z').to_a.shuffle[0..7].join
    @dish_image = DishImage.new(dish_id: dish_id, filename: filename)
    
    # save image
    image = params[:dish_image][:image]
    File.binwrite("public/dish_images/#{@dish_image.filename}", image.read)
    
    if @dish_image.save
      dish = Dish.find_by_id(dish_id)
      redirect_to dish_url(dish)
    else
      # TODO: エラーメッセージ
      render 'new'
    end
  end
  
  # private

  #   # マスアサインメント対策
  #   def dish_image_params
  #     params.require(:dish_image).permit(:dish_id, :filename)
  #   end
end
