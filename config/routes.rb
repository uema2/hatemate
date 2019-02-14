Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "about", to: "toppages#show"
  get "signup", to: "users#new"
  
  resources :users, only: [:show, :new, :create] do
    member do 
      get :hates
    end
  end
  resources :animes, only: [:show, :new] 
  resources :ratings, only: [:create, :destroy]
end
