Rails.application.routes.draw do
  devise_for :administrators
  devise_for :users

  root to: "pages#home"

  namespace :admin do
    root to: "products#index", :as => :administrator_root
    resources :products
    resources :orders, only: %i[index show update]
    resources :payments, only: %i[update]
    resources :shipments, only: %i[update]
  end

  resources :products, only: %i[show]
  resources :orders, only: %i[create]
  resources :cart_items, only: %i[create destroy update]

  namespace :orders do
    resource :billing_address, only: %i[new create]
  end

  get 'cart', to: 'cart_items#index'
  delete 'cart_items', to: 'cart_items#destroy_all', as: :clear_cart
end
