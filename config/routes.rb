Rails.application.routes.draw do
  root "blogs#index"
  post "/login", to: "authentication#login"
  post "/signup", to: "user#sign_up"

  resource :user, except: :create

  scope ":username" do
    get "/profile", to: "profiles#show"
    get "/followers", to: "follow#show_follower"
    get "/following", to: "follow#show_following"
  end

  get "/profiles", to: "profiles#index"
  match "/profile", to: "profiles#update", via: [:patch, :put]

  resources :blogs do
    member do
      get "/like", action: :like
      get "/unlike", action: :unlike
      get "/likes", action: :likes
    end

    resources :comments, shallow: true
  end

  resources :notifications, only: [:index, :show, :destroy]
  get "/:username", to: redirect("/%{username}/profile")
end
