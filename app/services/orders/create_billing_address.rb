# frozen_string_literal: true

require 'dry/monads'

module Orders
  class CreateBillingAddress
    include Dry::Monads[:result, :do]

    def call(user:, session:, address_params:)
      values = yield validate(address_params)
      payment = yield get_payment(user, session)
      yield persist(values, payment)

      Success('Billing Address has been created')
    end

    private

    def get_payment(user, session)
      order = Order.find(session[:order_id])

      if order.user == user
        Success(order.payment)
      else
        Failure('Order does not belong to user')
      end
    end

    def validate(address_params)
      validation = AddressContract.new.call(address_params.to_h)

      if validation.success?
        Success(address_params)
      else
        Failure(validation.errors)
      end
    end

    def persist(values, payment)
      address = Address.new(values)
      address.addressable = payment
      if address.save
        Success(address)
      else
        Failure('Address could not be saved')
      end
    end
  end
end
