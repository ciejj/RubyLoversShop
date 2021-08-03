# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    def index
      @pagy, @orders = pagy(Order.order(created_at: :desc))
    end

    def show
      @order = Order.find(params[:id]).decorate
    end
  end
end
