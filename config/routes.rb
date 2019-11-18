Rails.application.routes.draw do
  root "pages#home"

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"
  post "/signup", to: "users#create"
  get "/signup", to: "users#new"
  delete "/logout", to: "sessions#delete"
  post "/comments/:id", to: "comments#create"
  delete "/comments/:id", to: "comments#destroy"
  get "/search", to: "tours#search"
  post "/search", to: "tours#search"
  post "/likes/:id", to: "likes#create"
  delete "/likes/:id", to: "likes#destroy"
  namespace :admin do
    root "pages#home"
    resources :tours
    resources :categories, except: [:show, :new]
    resources :reviews
    resources :users, except: :edit
  end

  resources :tours, only: %i(index show)
  resources :users
  resources :reviews
  resources :categories, only: :show
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
