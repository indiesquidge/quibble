Rails.application.routes.draw do
  root "dashboard#index"

  get "/auth/:provider/callback", to: "sessions#create"
  get "/room/:room_name/", to: "rooms#show"
end
