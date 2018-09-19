Rails.application.routes.draw do
  devise_for :users
  root 'prototypes#index'

  resources :prototypes do
      resources :comments
      resources :likes,only:[:create,:destroy]
  end
  resources :users, only: [:show, :edit, :update]

  post   '/like/:prototype_id' => 'likes#like',   as: 'like'
  delete '/like/:prototype_id' => 'likes#unlike', as: 'unlike'


end
