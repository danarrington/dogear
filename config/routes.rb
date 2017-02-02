Rails.application.routes.draw do
  get "home/index"
  get "users/new"
  get "users/create"
  get "users/show"

  root :to => 'home#index'
  resources :books
  resources :users
  resource :session, only: [:new, :create, :destroy]

  patch 'books/:id/finish' => 'books#finish', :as => :finish_book
  patch 'books/:id/reopen' => 'books#reopen', :as => :reopen_book
  post '/temporize' => 'home#temporize'
end
