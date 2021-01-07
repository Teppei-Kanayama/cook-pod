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
      render 'new'
    end
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(dish_params)
      flash[:success] = "正常に編集されました！すやすや"
      redirect_to @dish
    else
      render 'edit'
    end
  end

  def destroy
    dish_id = params[:id]
    dish = Dish.find(dish_id)
    # 画像が登録されている料理を消すと、DishImages側は削除されずに不整合になってしまうので、いったんエラー処理
    # if DishImage.where(dish_id: dish_id)
    #   flash[:alert] = "画像が登録されている料理は消せません。"
    #   redirect_to dish_url(dish)
    #   return
    # end
    dish.destroy
    flash[:success] = "正常に削除されました！ない"
    redirect_to root_url
  end

  private

    # マスアサインメント対策
    def dish_params
      params.require(:dish).permit(:name, :url, :memo)
    end
end
