# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart_items = @cart.cart_items.includes(:product, product: { main_image_attachment: :blob })
  end

  def add
    result = AddProductToCart.new.call(product_id: params[:product_id], cart: @cart)

    if result.success?
      flash[:notice] = result.value!
    else
      flash[:alert] = result.failure
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
