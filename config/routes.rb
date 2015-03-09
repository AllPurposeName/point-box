Rails.application.routes.draw do
  resources :users
  resources :rewards
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  delete '/logout', to: "sessions#destroy"
  post '/user_rewards', to: "user_rewards#create"
  post '/points', to: "points#create"
  delete '/points', to: "points#destroy"
end
