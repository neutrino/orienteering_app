Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :events, only: [:index, :show]
      resources :tracks, only: [:index, :show] do
        member do
          post 'result'
        end
      end
      get 'tracks/search/:info_tag', to: 'tracks#search', as: 'search'
    end
  end
  resources :events do
    resources :tracks do
      resources :control_points, shallow: true
      resources :results, only: [:index, :destroy], shallow: true
    end
  end

  root to: 'visitors#index'

  devise_for :users
  resources :users
end
