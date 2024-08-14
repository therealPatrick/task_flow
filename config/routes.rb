
Rails.application.routes.draw do
  root 'pages#landing'
  get 'pricing', to: 'pages#pricing'
  get 'use_case', to: 'pages#use_case'

  # Other routes for your app
  resources :tasks
  devise_for :users
end
