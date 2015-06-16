Rails.application.routes.draw do
  root "dashboard#index"

  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :rooms, param: :slug
  resources :messages

end
