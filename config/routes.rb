Rails.application.routes.draw do
  root "blogs#index"
  post "/login", to: "authentication#login"

  resources :users, except: [:index, :show] do
    get "/profile", action: :profile, on: :member
    get "/followers", to: "follow#followers"
    get "/following", to: "follow#following"
  end
  get "/followers/:id", to: "follow#show_follower"
  get "/following/:id", to: "follow#show_following"
  get "/unfollow/:id", to: "follow#destroy"

  resources :blogs do
    member do
      get "/like", action: :like
      get "/unlike", action: :unlike
      get "/likes", action: :likes
    end

    resources :comments, shallow: true do
      get "/replies", action: :index
    end
  end

  resources :notifications, only: [:index, :show, :destroy]
end
