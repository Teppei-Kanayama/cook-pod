class DishImagesController < ApplicationController
  def new
    @dish_image = DishImage.new
  end
  
  def create
    dish_id = params[:dish_image][:dish_id]
    image_binary = params[:dish_image][:image]
    
    if image_binary == nil
      flash.now[:danger] = "画像を選択してください。"
      @dish_image = DishImage.new
      render 'new'
      return
    end
    
    filename = generate_random_filename()
    save_image(image_binary, filename)
    @dish_image = DishImage.new(dish_id: dish_id, filename: filename)
    
    if @dish_image.save
      flash[:success] = "正常に登録されました！えらい！"   # nowが必要な時と必要でない時の違いがわからない
      dish = Dish.find_by_id(dish_id)
      redirect_to dish_url(dish)
    else
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
