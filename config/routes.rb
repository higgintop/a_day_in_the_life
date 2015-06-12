Rails.application.routes.draw do
  root 'home#index'

  resource :user_session, only: [:new, :create, :destroy]
  #resources :users, only: [:new, :create] do
    #resources :journals, except: [:show] do
      #resources :entries, only: [:index, :new, :create]
    #end
  #end

  resources :users, only: [:new, :create] do
    resources :journals, except: [:show]
  end

  resources :journals, only: [:show] do
    resources :entries
  end
end
