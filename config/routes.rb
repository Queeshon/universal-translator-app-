Rails.application.routes.draw do

  root 'users#greeting'

  resources :users

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get '/welcome', to: 'sessions#show'
  post '/logout', to: 'session#destroy'

  resources :conversations


end
