# frozen_string_literal: true

module Admin
  class PaymentsController < AdminController
    before_action :set_payment, only: %i[update]

    def update
      event = params[:event]

      if Payments::StateService.new(@payment).send(event)
        flash[:success] = "Payment #{event}ed."
      else
        flash[:alert] = "Can\'t  #{event} payment"
      end
      redirect_to admin_order_path(@payment.order)
    end

    private

    def set_payment
      @payment = Payment.find(params[:id])
    end
  end
end
