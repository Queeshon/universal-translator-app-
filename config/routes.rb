Rails.application.routes.draw do

  root 'users#greeting'

  resources :users

  mount ActionCable.server => '/cable'

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'sessions'
  get '/welcome', to: 'sessions#show'
  post '/logout', to: 'sessions#destroy'

  resources :conversations


end
