# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'

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

  resources :rooms do
    member do
      get 'show_renters'
      put 'add_renter_to_room'
      delete 'destroy_renter_from_room'
    end
  end
end
