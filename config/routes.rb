# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'
  resources :timesheets

  # it will redirect to users dashboard with url 127:0:0:1/users
  namespace :users do
    resources :dashboard
    root 'dashboard#index'
  end

  # it will redirect to users dashboard with url 127:0:0:1/admins
  namespace :admins do
    resources :dashboard
    root 'dashboard#index'
  end

  resource :users do
    resources :rooms
  end

  resource :users do
    resources :renters
  end

  resource :users do
    resources :services
  end

  # resources :users do
  #   resources :timesheets
  # end
end
