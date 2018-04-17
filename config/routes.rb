Rails.application.routes.draw do

  root 'users#greeting'

  resources :users

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'sessions'
  get '/welcome', to: 'sessions#show'
  get '/logout', to: 'sessions#destroy'

  resources :conversations


end
