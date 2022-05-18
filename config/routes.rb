Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root to: 'home#index'
  resources :companies, only: [:index, :show, :new, :create, :edit, :update] do
    resources :prices, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :vehicles, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :delivery_times, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  resources :addresses, only: [:index, :show, :new, :create, :edit, :update]
  resources :email_domains, only: [:index, :show, :new, :create, :edit, :update]
  resources :products, only: [:index, :show, :new, :create, :edit, :update]
end
