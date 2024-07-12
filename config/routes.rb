Rails.application.routes.draw do
  resources :visits, only: [:create, :update, :index, :destroy]
  resources :users, only: [:index, :show, :create, :update, :destroy]
  post '/login', to: 'users#login'

end
