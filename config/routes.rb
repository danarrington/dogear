# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  resources :books
  resources :users
  resources :user, only: %i[new create show]
  resource :session, only: %i[new create destroy]
end
