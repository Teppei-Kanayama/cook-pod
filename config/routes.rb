Rails.application.routes.draw do
  get '/record', to: 'dish_images#new'
  post '/record', to: 'dish_images#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'dishes#index'
	
	resources :dishes
end
