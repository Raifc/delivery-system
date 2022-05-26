Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  root to: 'home#index'

  resources :companies, only: [:index, :show, :new, :create, :edit, :update] do
    resources :prices
    resources :vehicles
    resources :delivery_times
    resources :service_orders do
      #get 'service_order_review', to: 'service_orders#service_order_review'
      resources :route_updates
    end
  end

  resources :service_orders do
    get 'search', on: :collection
  end

  resources :addresses
  #resources :email_domains
  resources :products
  get 'price_queries', to: 'price_queries#calculate_prices'
end
