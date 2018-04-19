Rails.application.routes.draw do

  root 'users#greeting'

  mount ActionCable.server => '/cable'

  resources :users, :chatrooms, :messages

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'sessions'
  get '/welcome', to: 'sessions#show'
  get '/logout', to: 'sessions#destroy'
  # get '/delete_conversation', to: 'conversations#destroy', as: 'delete'
  get '/your_chatrooms', to: 'sessions#your_chatrooms'


end
