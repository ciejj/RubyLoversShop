# frozen_string_literal: true

require 'dry/monads'

module Orders
  class CreateOrder
    include Dry::Monads[:result, :do]

    def call(user:, session:)
      Order.transaction do
        cart_items = yield validate_cart(user)
        order = yield create_order(user, session)
        yield add_products_to_order(order, cart_items)
        yield link_payment_to_order(order)
        yield link_shipment_to_order(order)
        yield clear_cart(cart_items)

        Success("Order has been placed with id: #{order.id}")
      end
    end

    private

    def validate_cart(user)
      cart_items = user.cart_items
      if cart_items.empty?
        Failure('Can\'t place order with an empty cart')
      else
        Success(cart_items)
      end
    end

    def create_order(user, session)
      order = Order.create(state: :new, user: user)

      if order
        session[:order_id] = order.id
        Success(order)
      else
        Failue('Creating order has failed')
      end
    end

    def add_products_to_order(order, cart_items)
      cart_items.each do |cart_item|
        OrderItem.create(product: cart_item.product, order: order)
      end

      if cart_items.count == order.order_items.count
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

    def link_shipment_to_order(order)
      shipment = Shipment.create(order: order)

      if shipment
        Success(shipment)
      else
        Failure('Linking shipment to order has failed')
      end
    end

    def clear_cart(cart_items)
      cart_items.destroy_all

      if cart_items.empty?
        Success(cart_items)
      else
        Failure('Cart could not be emptied')
      end
    end
  end
end
