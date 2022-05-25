Rails.application.routes.draw do
  root to: 'site/home#index'
  devise_for :admins
  devise_for :users

  namespace :site do
    get 'home/index'
  end

  namespace :users_space do
    get 'home/index'
  end

  namespace :admins_space do
    get 'home/index'
  end
  # get 'inicio', to: 'site/home#index'

  resources :companies, only: [:index, :show, :new, :create, :edit, :update] do
    resources :prices
    resources :vehicles
    resources :delivery_times
    resources :service_orders do
      resources :route_updates
    end
  end

  resources :service_orders do
    get 'search', on: :collection
  end

  resources :addresses
  resources :email_domains
  resources :products
  get 'price_queries', to: 'price_queries#calculate_prices'
end
