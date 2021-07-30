# frozen_string_literal: true

module Admin
  class PaymentsController < AdminController
    before_action :set_payment, only: %i[complete fail]

    def complete
      Payments::StateService.new(@payment).complete!
      redirect_to admin_order_path(@payment.order)
    end

    def fail
      Payments::StateService.new(@payment).fail!
      redirect_to admin_order_path(@payment.order)
    end

    private

    def set_payment
      @payment = Payment.find(params[:id])
    end
  end
end
