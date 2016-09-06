Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :invoices, only: [:show, :index] do
        get '/find', to: 'invoices/search#show', on: :collection
        get '/find_all', to: 'invoices/search#index', on: :collection
        get '/random', to: 'invoices/random#show', on: :collection
        get '/transactions', to: 'invoices/transactions#index', on: :member
        get '/invoice_items', to: 'invoices/invoice_items#index', on: :member
        get '/items', to: 'invoices/items#index', on: :member
        get '/customer', to: 'invoices/customers#show', on: :member
        get '/merchant', to: 'invoices/merchants#show', on: :member
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

      resources :customers, only: [:show, :index] do
        get '/find', to: 'customers/search#show', on: :collection
        get '/find_all', to: 'customers/search#index', on: :collection
        get '/random', to: 'customers/random#show', on: :collection
      end

      resources :transactions, only: [:show, :index] do
        get '/find', to: 'transactions/search#show', on: :collection
        get '/find_all', to: 'transactions/search#index', on: :collection
        get '/random', to: 'transactions/random#show', on: :collection
      end
    end
  end
end
