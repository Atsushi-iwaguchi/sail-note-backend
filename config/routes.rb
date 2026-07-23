Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :auth do
        post "register", to: "users#create"
        post "login", to: "sessions#create"
      end

      get "me", to: "users#me"

      resources :practice_records, only: [:index, :create, :show, :update, :destroy] do
        resources :comments, only: [:index, :create]
      end
      resources :comments, only: [:destroy]
      resources :tournaments, only: [:index, :create, :show, :update, :destroy] do
        resources :tournament_entries, only: [:index, :create]
      end
      resources :tournament_entries, only: [:update, :destroy] do 
        resources :race_results, only: [:index, :create]
      end

      resources :race_results, only: [:update, :destroy]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
