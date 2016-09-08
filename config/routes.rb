Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :invoices, only: [:show, :index] do
        collection do
          get '/find', to: 'invoices/search#show'
          get '/find_all', to: 'invoices/search#index'
          get '/random', to: 'invoices/random#show'
        end
        member do
          get '/transactions', to: 'invoices/transactions#index'
          get '/invoice_items', to: 'invoices/invoice_items#index'
          get '/items', to: 'invoices/items#index'
          get '/customer', to: 'invoices/customers#show'
          get '/merchant', to: 'invoices/merchants#show'
        end
      end

      resources :merchants, only: [:show, :index] do
        collection do
          get '/most_items', to: 'merchants/items_analysis#index'
          get '/find', to: 'merchants/search#show'
          get '/find_all', to: 'merchants/search#index'
          get '/random', to: 'merchants/random#show'
          get '/most_revenue', to: 'merchants/revenue#index'
        end
        member do
          get '/revenue', to: 'merchants/revenue#show'
          get '/items', to: 'merchants/items#index'
          get '/invoices', to: 'merchants/invoices#index'
          get '/customers_with_pending_invoices',
              to: 'merchants/customers#index'
          get '/favorite_customer', to: 'merchants/customers#show'
        end
      end

      resources :customers, only: [:show, :index] do
        collection do
          get '/find', to: 'customers/search#show'
          get '/find_all', to: 'customers/search#index'
          get '/random', to: 'customers/random#show'
        end
        member do
          get '/invoices', to: 'customers/invoices#index'
          get '/transactions', to: 'customers/transactions#index'
          get '/favorite_merchant', to: 'customers/merchants#show'
        end
      end

      resources :transactions, only: [:show, :index] do
        collection do
          get '/find', to: 'transactions/search#show'
          get '/find_all', to: 'transactions/search#index'
          get '/random', to: 'transactions/random#show'
        end
        get '/invoice', to: 'transactions/invoice#show', on: :member
      end

      resources :items, only: [:show, :index] do
        collection do
          get '/find', to: 'items/search#show'
          get '/find_all', to: 'items/search#index'
          get '/random', to: 'items/random#show'
          get '/most_revenue', to: 'items/revenue#index'
          get '/most_items', to: 'items/items_sold#index'
        end
        member do
          get '/invoice_items', to: 'items/invoice_items#index'
          get '/merchant', to: 'items/merchants#show'
        end
      end

      resources :invoice_items, only: [:show, :index] do
        collection do
          get '/find', to: 'invoice_items/search#show'
          get '/find_all', to: 'invoice_items/search#index'
          get '/random', to: 'invoice_items/random#show'
        end
        member do
          get '/invoice', to: 'invoice_items/invoices#show'
          get '/item', to: 'invoice_items/items#show'
        end
      end
    end
  end
end
