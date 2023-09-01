Rails.application.routes.draw do
  root "authentication#show"

  resource :login, controller: :authentication, only: %i[show create destroy]

  resource :user, path_names: { new: :signup }
  resource :follow, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]

  resources :profiles, except: [:new, :destroy], param: :username do
    post "/search", action: "search", on: :collection
    member do
      get "/followers", to: "follows#list_followers"
      get "/following", to: "follows#list_following"
    end
  end

  resources :blogs do
    resources :comments, shallow: true, except: :index
    resource :like, only: [:create, :destroy]
    get "/search", action: "search", on: :collection
  end

  scope "/activity", controller: "activities", as: :activity do
    get "/drafts", action: :drafts
    get "/blogs", action: :blogs
    get "/likes", action: :likes
    get "/comments", action: :comments
  end
end
