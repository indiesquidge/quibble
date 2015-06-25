Rails.application.routes.draw do
  root "dashboard#index"

  get "/auth/:provider/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :rooms, param: :slug
  post "/animation_catcher", to: "rooms#catch_animation"
  get "/send_animation", to: "rooms#send_animation"
  resources :messages

end
