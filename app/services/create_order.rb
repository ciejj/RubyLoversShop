# frozen_string_literal: true

require 'dry/monads'

class CreateOrder
  include Dry::Monads[:result, :do]

  def call(cart:, user:)
    Order.transaction do
      cart = yield validate_cart(cart)
      order = yield create_order(user)
      yield add_products_to_order(order, cart)
      yield link_payment_to_order(order)
      yield clear_cart(cart)

      Success("Order has been placed with id: #{order.id}")
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

  def create_order(user)
    order = Order.create(state: :new, user: user)

    if order
      Success(order)
    else
      Failue('Creating order has failed')
    end
  end

  def add_products_to_order(order, cart)
    cart.cart_items.each do |cart_item|
      OrderItem.create(product: cart_item.product, order: order)
    end

    if cart.cart_items.count == order.order_items.count
      Success(order)
    else
      Failure('Adding products to order has failed')
    end
  end

  def link_payment_to_order(order)
    payment = Payment.create(order: order)

    if payment
      Success(payment)
    else
      Failure('Linking payment to order has failed')
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
