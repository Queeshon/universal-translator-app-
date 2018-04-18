Rails.application.routes.draw do

  root 'users#greeting'

  resources :users

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'sessions'
  get '/welcome', to: 'sessions#show'
  post '/logout', to: 'sessions#destroy'

  resources :conversations
  # get '/delete_conversation', to: 'conversations#destroy', as: 'delete'


end
