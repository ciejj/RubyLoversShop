# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    def index
      @pagy, @orders = pagy(Order.includes(%i[shipment payment]).order(created_at: :desc).decorate)
    end

    def show
      @order = Order.find(params[:id]).decorate
    end
  end
end
