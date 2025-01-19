Rails.application.routes.draw do
  resources :simulations
  resources :simulation_proposals, only: %i[index show]

  get "dashboard", to: "dashboard#show"
  get "home", to: "home#index"
  root "home#index"

  resource :session, only: %i[new create destroy]
  resources :passwords, param: :token, only: %i[new create edit update]

  get "up", to: "rails/health#show", as: :rails_health_check
end
