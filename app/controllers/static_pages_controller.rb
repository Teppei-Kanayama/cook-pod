class StaticPagesController < ApplicationController
  def recommend
    @dishes = Dish.all
  end

  def calendar
  end
end
