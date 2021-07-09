Rails.application.routes.draw do
  devise_for :administrators
  devise_for :users

  root to: "pages#home"

  namespace :admin do
    root to: "products#index", :as => :administrator_root
    resources :products
  end

  resources :products, only: %i[show]
  resources :orders, only: %i[create]

  get 'cart', to: "carts#show"
  delete 'cart', to: "carts#destroy"
  post 'cart', to: "carts#add", as: "add_to_cart"
end
