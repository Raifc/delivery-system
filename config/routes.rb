Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: 'home#index'

  resources :companies, only: %i[index show new create edit update] do
    resources :prices, only: %i[index show new create edit update]
    resources :vehicles, only: %i[index show new create edit update]
    resources :delivery_times, only: %i[index show new create edit update]
    resources :service_orders, only: %i[index show new create edit update] do
      resources :route_updates, only: %i[index show new create edit update]
    end
  end

  resources :service_orders do
    get 'search', on: :collection
  end

  resources :addresses, only: %i[index show new create edit update]
  resources :products

  get 'price_queries_index', to: 'price_queries#index'
  get 'price_queries', to: 'price_queries#calculate_prices'
end
