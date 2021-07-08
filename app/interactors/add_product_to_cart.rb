# frozen_string_literal: true

class AddProductToCart
  include Interactor

  def call
    cart = context.cart
    product = context.product

    if cart.line_items.find_by(product_id: product.id)
      context.fail!(message: "#{product.name} is already in the cart")
    else
      LineItem.create(product: product, cart: cart)
      context.message = "Added #{product.name} to the cart"
    end
  end
end
