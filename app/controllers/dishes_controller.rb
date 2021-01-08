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
      @dish = Dish.find(dish_id)
      # TODO: 料理画像も返す
      # @dish_images = DishImage.where(dish_id: dish_id).to_ary()
      render json: @dish
    else
      render json: {"message": "404 Not Found"}  # TODO: いい感じのメッセージにする
    end
  end

  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      render json: @dish
    else
      render json: {"message": "500 Internal Server Error"}  # TODO: いい感じのメッセージにする
    end
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(dish_params)
      render json: @dish
    else
      render json: {"message": "500 Internal Server Error"}  # TODO: いい感じのメッセージにする
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
    # TODO: 失敗した場合のエラーハンドリング（存在しないリソースが指定された場合など）
    render json: {"message": "204 Resource Deleted Successfully"}
  end

  private

    # マスアサインメント対策
    def dish_params
      params.require(:dish).permit(:name, :url, :memo)
    end
end
