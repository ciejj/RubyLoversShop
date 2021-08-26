# frozen_string_literal: true

module Admin
  class PaymentsController < AdminController
    def update
      payment = Payment.find(params[:id])
      event = params[:event]

      if Payments::StateService.new(payment).send(event)
        flash[:success] = "Payment #{event}ed."
      else
        flash[:alert] = "Can\'t  #{event} payment"
      end
      redirect_to admin_order_path(payment.order)
    end
  end
end
