Rails.application.routes.draw do
  root "blogs#index"
  post "/login", to: "authentication#login"
  post "/signup", to: "users#create"

  resource :user, except: :create
  resource :follow, only: [:create, :destroy]
  resources :notifications, only: [:index, :show, :destroy]

  resources :profiles, only: [:index, :show, :update], param: :username do
    member do
      get "/blogs", to: "blogs#user_blogs", as: :user_blogs
      get "/followers", to: "follows#list_followers"
      get "/following", to: "follows#list_following"
    end
  end

  resources :blogs do
    resources :comments, shallow: true
    resource :like, only: [:create, :destroy]
  end

  scope "/activity", controller: "activities", as: :activity do
    get "/blogs", action: :blogs
    get "/likes", action: :likes
    get "/comments", action: :comments
  end
end
