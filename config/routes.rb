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
      resources :control_points, shallow: true, only: [:create, :destroy] do
        collection do
          post 'sort'
        end
      end
      resources :results, only: [:index, :destroy], shallow: true
    end
  end

  get 'results/', to: 'results#events'
  get 'results/:event_id', to: 'results#event'
  get 'results/:event_id/:track_id/overall', to: 'results#overall', :as => :overall
  get 'results/:event_id/:track_id/splits', to: 'results#splits', :as => :splits

  root to: 'visitors#index'

  devise_for :users
  resources :users
end
