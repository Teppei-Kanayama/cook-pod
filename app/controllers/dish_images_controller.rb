class DishImagesController < ApplicationController
  def new
    @dish_image = DishImage.new
  end
  
  def create
    @dish_image = DishImage.new(dish_image_params)
    if @dish_image.save
      # TODO: 詳細ページにリダイレクト
      @dishes = Dish.all
      render 'dishes/index'
    else
      # TODO: エラーメッセージ
      render 'new'
    end
  end
  
  private

    # マスアサインメント対策
    def dish_image_params
      params.require(:dish_image).permit(:dish_id, :filename)
    end
end
