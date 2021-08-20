# frozen_string_literal: true

module Admin
  class ShipmentsController < AdminController
    def update
      shipment = Shipment.find(params[:id])
      event = params[:event]

      if Shipments::StateService.new(shipment).send(event)
        flash[:success] = 'Shipment status change has been succesfull'
      else
        flash[:alert] = 'Can\'t change shipment status'
      end
      redirect_to admin_order_path(shipment.order)
    end
  end
end
