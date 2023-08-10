Rails.application.routes.draw do
  root "blogs#index"

  resources :blogs do
    get "/like", to: "blogs#like"
    delete "/unlike", to: "blogs#unlike"
    get "/likes", to: "blogs#likes"

    resources :comments, shallow: true do
      resources :replies, only: [:index]
    end
  end

  get "/users/:id", to: "users#show", as: :user
  resources :notifications, only: [:index, :show, :destroy]
end
