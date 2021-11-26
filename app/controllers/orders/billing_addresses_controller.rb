# frozen_string_literal: true

module Orders
  class BillingAddressesController < ApplicationController
    before_action :authenticate_user!

    def new
      @address = Address.new
    end

    def create
      result = Orders::CreateBillingAddress.new.call(user: current_user,
                                                     session: session,
                                                     address_params: address_params)

      if result.success?
        flash[:notice] = result.value!
        redirect_to root_path
      else
        @errors = result.failure
        @address = Address.new(address_params)
        render :new
      end
    end

    def address_params
      params.require(:address).permit(:street_name1, :street_name2,
                                      :city, :country, :state, :zip, :phone)
    end
  end
end
