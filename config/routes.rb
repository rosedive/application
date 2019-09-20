Rails.application.routes.draw do
  root 'tasks#index'
  resources :users
  resources :tasks
end
