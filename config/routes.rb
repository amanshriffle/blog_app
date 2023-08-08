Rails.application.routes.draw do
  root "blogs#index"
  resources :blogs do
    resources :comments do
      resources :replies
    end
  end
end
