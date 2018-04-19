Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
post '/messages/recorded', to: 'messages#recorded'
get '/messages/record', to: 'messages#record'
get 'http://localhost:3000/messages/record', to: 'messages#recorded'
# resources :messages
end
