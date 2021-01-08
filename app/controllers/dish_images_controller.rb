class DishImagesController < ApplicationController
  # local開発でCan't verify CSRF token authenticityと言われてしまうことへの対策
  # https://qiita.com/nishina555/items/4ffaf5cc57a384b66230
  # セキュリティ的に大丈夫か？
  skip_before_action :verify_authenticity_token

  def create
    dish_id = params[:dish_id]
    image_binary = params[:image]
    if image_binary == nil
      render json: {"message": "400 bad request. Image file might be incollect."}
      return
    end

    filename = generate_random_filename()
    save_image(image_binary, filename)
    @dish_image = DishImage.new(dish_id: dish_id, filename: filename)
    if @dish_image.save
      dish = Dish.find_by_id(dish_id)
      redirect_to dish_url(dish)
    else
      render json: {"message": "500 Internal Server Error"}
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
