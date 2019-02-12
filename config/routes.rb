Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "about", to: "toppages#show"
  get "signup", to: "users#new"
  resources :users, only: [:show, :new, :create]
  
  resources :animes, only: [:new]
end
