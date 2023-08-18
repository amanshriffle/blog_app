Rails.application.routes.draw do
  root "blogs#index"
  post "/login", to: "authentication#login"
  post "/signup", to: "users#sign_up"

  resource :user, except: :create

  scope ":username" do
    get "/profile", to: "profiles#show"
    get "/followers", to: "follow#followers"
    get "/following", to: "follow#following"
    get "/follow", to: "follow#create"
    get "/unfollow", to: "follow#destroy"
  end

  get "/profiles", to: "profiles#index"
  match "/profile", to: "profiles#update", via: [:patch, :put]

  resources :blogs do
    resources :comments, shallow: true
    member do
      get "/like", action: :like
      get "/unlike", action: :unlike
      get "/likes", action: :likes
    end
  end

  resources :notifications, only: [:index, :show, :destroy]
end
