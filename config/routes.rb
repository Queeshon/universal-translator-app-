Rails.application.routes.draw do

  root 'users#greeting'

  resources :users, :conversations
  post '/conversations/recorded', to: 'conversations#recorded'
  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'sessions'
  get '/welcome', to: 'sessions#show'
  get '/logout', to: 'sessions#destroy'
  get '/your_conversations', to: 'sessions#your_conversations'


end
