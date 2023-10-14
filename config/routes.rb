Rails.application.routes.draw do
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end

  # resources :posts, only: [:index, :show]
  root 'users#index'
end