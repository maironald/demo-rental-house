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
    member do
      resources :rooms
      resources :services
      resource :electric_waters, only: %i[show edit update]
      resource :invoices, only: %i[show_all_invoices] do
        get 'show_all_invoices'
      end
    end
  end

  resources :rooms do
    resources :invoices
    resources :renters, only: %i[new create]
    resource :renters, only: %i[index] do
      member do
        # room and renter
        get 'show_renters'
      end
    end
  end

  resources :renters, only: %i[destroy index update edit show] do
    collection do
      delete 'destroy_all', to: 'renters#destroy_all'
    end
  end
end
