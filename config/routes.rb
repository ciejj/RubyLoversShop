Rails.application.routes.draw do
  devise_for :administrators

  devise_for :users

  root to: "pages#home"

  namespace :admin do
    root to: "products#index", :as => :administrator_root
    resources :products
  end
end
