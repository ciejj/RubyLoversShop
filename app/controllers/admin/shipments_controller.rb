# frozen_string_literal: true

module Admin
  class ShipmentsController < AdminController
    before_action :set_shipment, only: %i[prepare ship fail cancel]

    def prepare
      if Shipments::StateService.new(@shipment).prepare!
        flash[:notice] = 'Shipment prepared'
      else
        flash[:alert] = 'Can\'t prepare the shipment'
      end
      redirect_to admin_order_path(@shipment.order)
    end

    def ship
      if Shipments::StateService.new(@shipment).ship!
        flash[:notice] = 'Shipment shipped'
      else
        flash[:alert] = 'Can\'t ship the shipment'
      end
      redirect_to admin_order_path(@shipment.order)
    end

    def fail
      if Shipments::StateService.new(@shipment).fail!
        flash[:notice] = 'Shipment failed'
      else
        flash[:alert] = 'Can\'t fail the shipment'
      end
      redirect_to admin_order_path(@shipment.order)
    end

    def cancel
      if Shipments::StateService.new(@shipment).cancel!
        flash[:notice] = 'Shipment canceled'
      else
        flash[:alert] = 'Can\'t cancel the shipment'
      end
      redirect_to admin_order_path(@shipment.order)
    end

    private

    def set_shipment
      @shipment = Shipment.find(params[:id])
    end
  end
end
