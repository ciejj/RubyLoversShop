Rails.application.routes.draw do
  devise_for :administrators
  devise_for :users

  root to: "pages#home"

  namespace :admin do
    root to: "products#index", :as => :administrator_root
    resources :products
  end

  get 'carts/:id', to: "carts#show", as: "cart"
  delete 'carts/:id', to: "carts#destroy"
  post 'carts', to: "carts#add", as: "add_to_cart"
end
