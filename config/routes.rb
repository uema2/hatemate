Rails.application.routes.draw do
  root to: "toppages#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  get "signup", to: "users#new"
  get "current_season", to: "animes#season"
  
  resources :users, only: [:show, :new, :create] do
    member do 
      get :hates
    end
  end
  resources :animes, only: [:show, :new] do
    member do
      get :season
    end
  end
  resources :ratings, only: [:create, :destroy]
end
