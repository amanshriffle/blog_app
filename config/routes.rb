Rails.application.routes.draw do
  root "blogs#index"

  resources :blogs do
    resources :comments do
      resources :replies, only: [:index]
    end
  end

  resources :users, only: [:show, :destroy] do
    resources :notifications, only: [:index, :show, :destroy]
  end
end
