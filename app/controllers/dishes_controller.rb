class DishesController < ApplicationController
  # local開発でCan't verify CSRF token authenticityと言われてしまうことへの対策
  # https://qiita.com/nishina555/items/4ffaf5cc57a384b66230
  # セキュリティ的に大丈夫か？
  skip_before_action :verify_authenticity_token

  def index
    render json: get_index_dishes()
  end

  def show
    dish_id = params[:id].to_i
    if Dish.ids.include?(dish_id)
      render json: get_show_dish(dish_id)
    else
      render json: {"message": "404 Not Found"}
    end
  end

  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      render json: @dish
    else
      render json: {"message": "500 Internal Server Error"}
    end
  end

  def update
    dish_id = params[:id].to_i
    if Dish.ids.include?(dish_id)
      @dish = Dish.find(dish_id)
      if @dish.update_attributes(dish_params)
        render json: @dish
      else
        render json: {"message": "500 Internal Server Error"}
      end
    else
      render json: {"message": "400 Bad Request"}
    end
  end

  def destroy
    dish_id = params[:id].to_i
    dish_exist = Dish.ids.include?(dish_id)
    has_no_image = DishImage.where(dish_id: dish_id).empty?
    if dish_exist && has_no_image
      dish = Dish.find(dish_id)
      dish.destroy
      render json: {"message": "204 Resource Deleted Successfully"}
    elsif not dish_exist
      render json: {"message": "400 Bad Request. The dish doesn't exist."}
    elsif not has_no_image  # 画像が登録されている料理を消すと、DishImages側は削除されずに不整合になってしまうので、いったんエラー処理
      render json: {"message": "400 Bad Request. A dish with image cannot be destroyed."}
    end
  end

  private

    # マスアサインメント対策
    def dish_params
      params.require(:dish).permit(:name, :url, :memo)
    end
end
