# frozen_string_literal: true

require 'dry/monads'

class AddProductToCart
  include Dry::Monads[:result, :do]

  def call(cart:, product_id:)
    product = yield find_product(product_id)
    cart_item = cart.cart_items.find_by(product_id: product.id)

    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      CartItem.create(product: product, cart: cart)
    end

    Success("Added #{product.name} to the cart")
  end

  private

  def find_product(id)
    product = Product.find_by(id: id)

    if product
      Success(product)
    else
      Failure('Product does not exist')
    end
  end
end
