Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :invoices, only: [:show, :index] do
        get '/find', to: 'invoices/search#show', on: :collection
        get '/find_all', to: 'invoices/search#index', on: :collection
        get '/random', to: 'invoices/random#show', on: :collection
      end

      resources :merchants, only: [:show, :index] do
        get '/most_items', to: 'merchants/items#index', on: :collection
        get '/find', to: 'merchants/search#show', on: :collection
        get '/find_all', to: 'merchants/search#index', on: :collection
        get '/random', to: 'merchants/random#show', on: :collection
      end

      resources :items, only: [:show, :index] do
        get '/most_revenue', to: 'items/revenue#index', on: :collection
      end
    end
  end
end
