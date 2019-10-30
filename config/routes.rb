Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  get 'sessions/create'
  resources :users
  root 'tasks#index'
  resources :tasks
  resources :users
 resources :sessions
 resources :sessions, only: [:new, :create, :destroy]
 get 'signup', to: 'users#new', as: 'signup'
 get 'login', to: 'sessions#new', as: 'login'
 get 'logout', to: 'sessions#destroy', as: 'logout'
 namespace :admin do
  resources :users
 end
end
