Rails.application.routes.draw do

  devise_for :users
  root to: 'home#index'
  post '/admin_controler/search_options' => 'admin_controler#search_options' 
  get '/admin_controler/index' => 'admin_controler#index'
  get '/admin_controler/users' => 'admin_controler#users'
  resources :posts do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
