Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'
  resources :tags, only: [:index, :show]
  resources :prototypes do
    resources :tags, only: [:destroy]
  end
  resources :users, only: [:show, :edit, :update]

end
