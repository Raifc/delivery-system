Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :companies, only: [:index, :show, :new, :create, :edit, :update]
  resources :vehicles, only: [:index, :show, :new, :create, :edit, :update]
  resources :addresses, only: [:index, :show, :new, :create, :edit, :update]
  resources :email_domains, only: [:index, :show, :new, :create, :edit, :update]
end
