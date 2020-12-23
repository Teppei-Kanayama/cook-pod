class DishImagesController < ApplicationController
  def new
    @dish_image = DishImage.new
  end
  
  def create
    dish_id = params[:dish_image][:dish_id]
    image_binary = params[:dish_image][:image]
    
    filename = generate_random_filename()
    save_image(image_binary, filename)
    @dish_image = DishImage.new(dish_id: dish_id, filename: filename)
    
    if @dish_image.save
      dish = Dish.find_by_id(dish_id)
      redirect_to dish_url(dish)
    else
      # TODO: エラーメッセージ
      render 'new'
    end
  end
  
  private
    def generate_random_filename()
      return ('a'..'z').to_a.shuffle[0..7].join
    end

    def save_image(image_binary, filename)
      File.binwrite("public/dish_images/#{filename}", image_binary.read)
    end

end
