Rails.application.routes.draw do

  resources :events do
    resources :tracks do
      resources :control_points, shallow: true
    end
  end

  root to: 'visitors#index'

  devise_for :users
  resources :users
end
