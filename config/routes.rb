Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "about", to: "toppages#show"
  get "signup", to: "users#new"
  resources :users, only: [:show, :new, :create]
end
