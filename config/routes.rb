Rails.application.routes.draw do

  resources :events do
    resources :tracks
  end

  root to: 'visitors#index'

  devise_for :users
  resources :users
end
