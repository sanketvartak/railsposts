Rails.application.routes.draw do
  devise_for :users
  root 'post#index' , as: 'home'

  get '/about' =>  'post#about' 
  get '/new' =>  'post#new' 
  get '/create' =>  'post#create' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :post do 
    resources :comments
  end
end
