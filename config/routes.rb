Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:show, :index] do
        get '/most_items', to: 'merchants/items#index', on: :collection
      end

      resources :items, only: [:show, :index] do
        get '/most_revenue', to: 'items/revenue#index', on: :collection
      end
    end
  end
end
