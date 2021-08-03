# frozen_string_literal: true

module Admin
  class PaymentsController < AdminController
    before_action :set_payment, only: %i[complete fail]

    def complete
      if Payments::StateService.new(@payment).complete!
        flash[:notice] = 'Payment completed'
      else
        flash[:alert] = 'Can\'t complete payment'
      end
      redirect_to admin_order_path(@payment.order)
    end

    def fail
      if Payments::StateService.new(@payment).fail!
        flash[:notice] = 'Payment failed'
      else
        flash[:alert] = 'Can\'t fail payment'
      end
      redirect_to admin_order_path(@payment.order)
    end

    private

    def set_payment
      @payment = Payment.find(params[:id])
    end
  end
end
