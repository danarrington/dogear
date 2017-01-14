Rails.application.routes.draw do
  get "home/index"
  get "users/new"
  get "users/create"
  get "users/show"

  root :to => 'home#index'
  resources :books
  resources :users

  patch 'books/:id/finish' => 'books#finish', :as => :finish_book
  patch 'books/:id/reopen' => 'books#reopen', :as => :reopen_book
  get '/signin' => 'sessions#new', :as => :sign_in
  post '/signin' => 'sessions#create'
  post '/temporize' => 'home#temporize'
end
