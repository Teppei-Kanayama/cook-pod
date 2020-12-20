class Dish < ApplicationRecord
	has_many :dish_images
	validates :name, presence: true
end
