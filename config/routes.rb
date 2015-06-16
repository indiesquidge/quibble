Rails.application.routes.draw do
  root "dashboard#index"

  get "/auth/:provider/callback", to: "sessions#create"
  resources :rooms, param: :slug
  resources :messages
end
