Rails.application.routes.draw do
  resources :answers
  resources :questions
  resources :formularies
  resources :visits
  resources :users
  post '/login', to: 'users#login'

end
