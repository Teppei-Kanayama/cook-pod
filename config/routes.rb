Rails.application.routes.draw do
  get '/recommend', to: 'static_pages#recommend'

  get '/calendar', to: 'static_pages#calendar'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'dishes#index'
	
	resources :dishes
end
