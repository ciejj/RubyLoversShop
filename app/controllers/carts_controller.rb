# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @line_items = @cart.line_items.includes(:product, product: { main_image_attachment: :blob })
  end

  def add
    product = Product.find(params[:product_id])
    result = AddProductToCart.call(product: product, cart: @cart)

    flash[:notice] = result.message

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @cart.destroy
    session[:cart_id] = nil
    flash[:notice] = 'Cart has been emptied'
    redirect_to root_path
  end
end
