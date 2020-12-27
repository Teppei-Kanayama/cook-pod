class Dish < ApplicationRecord
	has_many :dish_images
	validates :name, presence: true
	validates :url, presence: true
end
