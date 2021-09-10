# frozen_string_literal: true

require 'dry/monads'

module CartItems
  class UpdateQuantity
    include Dry::Monads[:result, :do]

    def call(params:)
      cart_item = yield get_cart_item(params)
      quantity = yield get_quantity(params)

      if quantity.zero?
        yield destroy(cart_item)
      else
        yield set_quantity(cart_item, quantity)
      end
      Success('Quantity update successful')
    end

    private

    def get_cart_item(params)
      cart_item = CartItem.find_by(id: params[:id])

      if cart_item
        Success(cart_item)
      else
        Failure('Cart Item is missing')
      end
    end

    def get_quantity(params)
      quantity = params[:cart_item][:quantity]

      if quantity
        Success(quantity.to_i)
      else
        Failure('Quantity is required')
      end
    end

    def destroy(cart_item)
      cart_item.destroy

      if cart_item.destroyed?
        Success('Cart Item deleted')
      else
        Failure('Cart Item could not be deleted')
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
