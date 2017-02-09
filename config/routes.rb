Rails.application.routes.draw do
  get "home/index"
  get "users/new"
  get "users/create"
  get "users/show"

  root :to => 'home#index'
  resources :books
  resources :users
  resource :session, only: [:new, :create, :destroy]

  post '/temporize' => 'home#temporize'
end
