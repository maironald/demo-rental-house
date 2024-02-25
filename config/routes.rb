# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'authentication/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :users do
    resources :dashboard
    root 'dashboard#index'
  end

  namespace :manager do
    resources :dashboard
    resources :rooms
    root 'dashboard#index'
  end

  namespace :admins do
    resources :dashboard do
      delete 'delete_user_account', on: :member, to: 'dashboard#delete_user_account'
      put 'restore_deleted_user', on: :member, to: 'dashboard#restore_deleted_user'
      delete 'destroy_user_account', on: :member, to: 'dashboard#destroy_user_account'
      get 'show_all_users_deleted', on: :collection, to: 'dashboard#show_all_users_deleted'
      put 'update_password_user', on: :member, to: 'dashboard#update_password_user'
      get 'edit_password_user', on: :member, to: 'dashboard#edit_password_user'
    end
    root 'dashboard#index'
  end

  resource :users do
    member do
      resources :rooms
      resources :services
      resource :electric_waters, only: %i[show]
      resource :invoices, only: %i[show_all_invoices] do
        get 'show_all_invoices'
      end
    end
  end

  resource :user do
    resource :settings
  end

  resources :renters, only: %i[destroy index update edit show] do
    collection do
      delete 'destroy_all', to: 'renters#destroy_all'
    end
  end

  resource :admins do
    resources :notifications
  end

  resource :users do
    resources :notifications, only: %i[show]
  end

  resource :pages do
    collection do
      get 'edit_information', to: 'pages#edit_information'
      put 'update_information', to: 'pages#update_information'
    end
  end

  root 'home#index'
end
