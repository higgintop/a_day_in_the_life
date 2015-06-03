Rails.application.routes.draw do
  root 'home#index'

  resource :user_session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :journals, only: [:index]
end
