Rails.application.routes.draw do
  root to: 'home#index'
  resources :companies, only: [:index, :show, :new, :create, :edit, :update]
  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update]
  resources :addresses, only: [:index, :show, :new, :create, :edit, :update]
  resources :email_domains, only: [:index, :show, :new, :create, :edit, :update]
  resources :products, only: [:index, :show, :new, :create, :edit, :update]
  resources :prices, only: [:index, :show, :new, :create, :edit, :update]
end
