Rails.application.routes.draw do
  root "blogs#index"

  resources :blogs do
    get "/like/:user_id", to: "blogs#like"
    delete "/unlike/:user_id", to: "blogs#unlike"

    resources :comments do
      resources :replies, only: [:index]
    end
  end

  resources :users, only: [:show, :destroy] do
    resources :notifications, only: [:index, :show, :destroy]
  end
end
