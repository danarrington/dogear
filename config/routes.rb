# frozen_string_literal: true

Rails.application.routes.draw do
  root :to => 'home#index'
  resources :books
  resources :users
  resources :user, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
end
