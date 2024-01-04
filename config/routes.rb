# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :home
  resources :timesheets

  namespace :admins do
    resources :dashboard
    root 'dashboard#index'
  end

  # resources :users do
  #   resources :timesheets
  # end
end
