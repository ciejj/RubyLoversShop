# frozen_string_literal: true

module Admin
  class OrdersController < AdminController
    def index
      @pagy, @orders = pagy(Order.includes(%i[shipment payment]).order(created_at: :desc).decorate)
    end

    def show
      @order = Order.find(params[:id]).decorate
    end

    def update
      order = Order.find(params[:id])
      event = params[:event]

      if Orders::StateService.new(order).send(event)
        flash[:success] = 'Order\'s status change has been succesfull'
      else
        flash[:alert] = 'Can\'t change order\'s status'
      end
      redirect_to admin_order_path(order)
    end
  end
end
