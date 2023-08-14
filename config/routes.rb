Rails.application.routes.draw do
  root "blogs#index"
  post "/login", to: "authentication#login"

  resources :blogs do
    get "/like", to: "blogs#like"
    get "/unlike", to: "blogs#unlike"
    get "/likes", to: "blogs#likes"

    resources :comments, shallow: true do
      resources :replies, only: [:index]
    end
  end

  get "/users/:id", to: "users#show", as: :user
  resources :notifications, only: [:index, :show, :destroy]

  get "/followers", to: "follow#followers"
  get "/following", to: "follow#following"
  get "/followers/:id", to: "follow#show_follower"
  get "/following/:id", to: "follow#show_following"
  get "/unfollow/:id", to: "follow#destroy"
end
