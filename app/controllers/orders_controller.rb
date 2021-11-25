# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    result = Orders::CreateOrder.new.call(user: current_user, session: session)

    if result.success?
      flash[:notice] = result.value!
      redirect_to new_orders_billing_address_path
    else
      flash[:alert] = result.failure
      redirect_to cart_path
    end
  end
end
