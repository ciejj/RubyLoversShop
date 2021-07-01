# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :initialize_cart

  def show
    @cart = Cart.find(params[:id])
  end

  def add
    product = Product.find(params[:product_id])
    item_added = @cart.add_product(product)

    if item_added.nil?
      flash[:notice] = "#{product.name} is already in the cart"
    else
      item_added.save
      flash[:notice] = "Added #{product.name} to the cart"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @cart.destroy
    session[:cart_id] = nil
    flash[:notice] = 'Cart has been emptied'
    redirect_to root_path
  end
end
