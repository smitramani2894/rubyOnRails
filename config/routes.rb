Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "registrations/new"
  get "registrations/create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # get "/users", to: "users#index"

  # post "/users", to: "users#create"

  # get "/users/:id", to: "users#show"

  # patch "/users/:id", to: "users#update"

  # delete "/users/:id", to: "users#delete"


  # resources :users do
  # resources :posts
  # end

  resources :users

  resources :posts # creates routes automatically

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/register", to: "registrations#new"
  post "/register", to: "registrations#create"


  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
