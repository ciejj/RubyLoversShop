# frozen_string_literal: true

class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items.includes(:product, product: { main_image_attachment: :blob }).decorate
  end

  def create
    result = CartItems::CreateOrIncrement.new.call(product_id: params[:product_id],
                                                   quantity: params[:quantity], user: current_user)

    result.success? ? flash[:notice] = result.value! : flash[:alert] = result.failure

    redirect_back(fallback_location: root_path)
  end

  def destroy
    result = CartItems::DeleteSingle.new.call(id: params[:id], user: current_user)

    flash[:alert] = result.failure unless result.success?
    redirect_back(fallback_location: root_path)
  end

  def update
    result = CartItems::UpdateQuantity.new.call(id: params[:id], quantity: update_params[:quantity], user: current_user)

    flash[:alert] = result.failure unless result.success?
    redirect_back(fallback_location: cart_path)
  end

  def destroy_all
    CartItem.where(user_id: current_user.id).destroy_all
    redirect_to root_path, notice: 'Cart has been emptied'
  end

  private

  def update_params
    params.require(:cart_item).permit(:quantity)
  end
end
