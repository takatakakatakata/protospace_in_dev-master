Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :tags, only: [:index, :show]
  resources :prototypes do
    resources :tags, only: [:destroy]
    resources :comments
    resources :likes,only:[:create,:destroy]
  end
  resources :users, only: [:show, :edit, :update]

  post   '/like/:prototype_id' => 'likes#like',   as: 'like'
  delete '/like/:prototype_id' => 'likes#unlike', as: 'unlike'
end
