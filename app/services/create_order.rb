# frozen_string_literal: true

require 'dry/monads'

class CreateOrder
  include Dry::Monads[:result, :do]

  def call(cart:, user:)
    Order.transaction do
      cart = yield validate_cart(cart)
      yield create_order(user)
      clear_cart(cart)

      Success('Order has been placed')
    end
  end

  private

  def clear_cart(cart)
    cart.cart_items.destroy_all

    if cart.empty?
      Success(cart)
    else
      Failure('Cart could not be emptied')
    end
  end

  def create_order(user)
    order = Order.create(state: :new, user: user)

    if order
      Success(order)
    else
      Failue('Creating order has failed')
    end
  end

  def validate_cart(cart)
    if cart.empty?
      Failure('Can\'t place order with an empty cart')
    else
      Success(cart)
    end
  end
end
