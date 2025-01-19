Rails.application.routes.draw do
  concern :api do
    resources :simulations, only: %i[show index create update destroy edit]
    resources :simulation_proposals, only: %i[index show]
  end

  namespace :v1 do
    concerns :api
  end

  get "home", to: "home#index"
  root "home#index"

  resource :session, only: %i[new create destroy]
  resources :passwords, param: :token, only: %i[new create edit update]

  get "up", to: "rails/health#show", as: :rails_health_check
end
