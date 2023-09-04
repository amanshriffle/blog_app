Rails.application.routes.draw do
  root "sessions#show"

  resource :login, controller: :sessions, only: %i[show create destroy]
  resource :follow, only: [:create, :destroy]
  resources :notifications, only: [:index, :destroy]

  resource :user, path_names: { new: :signup }, except: :show do
    get "confirm_password", action: "confirm_password"
  end

  resources :profiles, except: [:new, :destroy, :index], param: :username do
    member do
      get "/followers", to: "follows#list_followers"
      get "/following", to: "follows#list_following"
    end
  end

  resources :blogs do
    resources :comments, shallow: true, except: :index
    resource :like, only: [:create, :destroy]
  end

  get "/search", to: "blogs#search"
end
