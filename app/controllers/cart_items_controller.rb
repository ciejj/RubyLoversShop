# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items.includes(:product, product: { main_image_attachment: :blob }).decorate
  end

  def create
    result = AddProductToCart.new.call(product_id: params[:product_id], user_id: current_user.id)

    if result.success?
      flash[:notice] = result.value!
    else
      flash[:alert] = result.failure
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    CartItem.where(user_id: current_user.id).destroy_all
    flash[:notice] = 'Cart has been emptied'
    redirect_to root_path
  end
end