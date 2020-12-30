class DishesController < ApplicationController
  def index
    @dishes = get_index_dishes()
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
      flash.now[:success] = "正常に登録されました！おつかれさば"  # nowが必要な時と必要でない時の違いがわからない
      @dishes = get_index_dishes()
      render 'index'
    else
      # TODO: エラーメッセージ
      render 'new'
    end
  end
  
  def edit
    @dish = Dish.find(params[:id])
  end
  
  private

    # マスアサインメント対策
    def dish_params
      params.require(:dish).permit(:name, :url, :memo)
    end
end
