Rails.application.routes.draw do
  root "authentication#show"
  get "/signup", to: "users#new"

  resource :login, controller: :authentication, path_names: { new: :login }, only: %i[show create destroy]

  resource :user, except: :new
  resource :follow, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]

  resources :profiles, only: [:index, :show, :edit, :update], param: :username do
    post "/search", action: "search", on: :collection
    member do
      get "/blogs", to: "blogs#user_blogs", as: :user_blogs
      get "/followers", to: "follows#list_followers"
      get "/following", to: "follows#list_following"
    end
  end

  resources :blogs do
    resources :comments, shallow: true
    resource :like, only: [:create, :destroy]
    post "/search", action: "search", on: :collection
  end

  scope "/activity", controller: "activities", as: :activity do
    get "/drafts", action: :drafts
    get "/blogs", action: :blogs
    get "/likes", action: :likes
    get "/comments", action: :comments
  end
end
