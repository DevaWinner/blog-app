Rails.application.routes.draw do
  devise_for :users, path: 'auth',
                     path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
    root to: 'devise/sessions#new'
  end
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments ,only:[:index,:new,:create]
      resources :likes ,only:[:create]
    end
  end
end