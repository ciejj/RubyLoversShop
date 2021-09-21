# frozen_string_literal: true

require 'dry/monads'

module CartItems
  class UpdateQuantity < BaseService
    include Dry::Monads[:result, :do]

    def call(id:, quantity:, user:)
      cart_item = yield get_cart_item(id, user)
      new_quantity = yield validate_quantity(quantity.to_i)

      if new_quantity.zero?
        yield destroy(cart_item)
      else
        yield set_quantity(cart_item, new_quantity)
      end
      Success('Quantity update successful')
    end

    private

    def validate_quantity(quantity)
      if quantity >= 0
        Success(quantity)
      else
        Failure('Incorrect quantity')
      end
    end

    def set_quantity(cart_item, quantity)
      cart_item.update(quantity: quantity)

      if cart_item.valid?
        Success('Cart Item quantity updated')
      else
        Failure('Cart Item quantity could not be updated')
      end
    end
  end
end
