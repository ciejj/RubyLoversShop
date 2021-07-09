# frozen_string_literal: true

require 'dry/monads'

class CreateOrder
  include Dry::Monads[:result, :do]

  def call(cart:, user:)
    cart = yield validate_cart(cart)

    order = Order.new(state: :new, user: user)

    if order.save
      clear_cart(cart)
      Success('Order has been placed')
    else
      Failure('Placing order has failed')
    end
  end

  private

  def validate_cart(cart)
    if cart.empty?
      Failure('Can\'t place order with an empty cart')
    else
      Success(cart)
    end
  end

  def clear_cart(cart)
    cart.cart_items.destroy_all

    if cart.empty?
      Success(cart)
    else
      Failure('Cart could not be emptied')
    end
  end
end
