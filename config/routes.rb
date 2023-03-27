# frozen_string_literal: true

Rails.application.routes.draw do
  resources :feedbacks
  # Defines the root path route ("/")
  root 'projects#index'
  devise_for :users
  resources :projects
  resources :project_updates, only: [:edit, :update, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
