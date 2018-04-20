Rails.application.routes.draw do

  root 'users#greeting'

  resources :users, :conversations

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'sessions'
  get '/welcome', to: 'sessions#show'
  get '/search', to: 'sessions#search', as: 'search'
  get '/logout', to: 'sessions#destroy'
  get '/your_conversations', to: 'sessions#your_conversations'


end
