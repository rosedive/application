Rails.application.routes.draw do
  resources :users
  resources :sessions
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  root 'tasks#index'
  resources :tasks
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
