Rails.application.routes.draw do
  root 'posts#index'
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :posts
end
