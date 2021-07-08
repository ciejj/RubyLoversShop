# frozen_string_literal: true

require 'dry/monads'

class AddProductToCart
  include Dry::Monads[:result]

  def call(cart:, product_id:)
    find_product(product_id).bind do |product|
      if cart.line_items.find_by(product_id: product.id)
        Failure("#{product.name} is already in the cart")
      else
        LineItem.create(product: product, cart: cart)
        Success("Added #{product.name} to the cart")
      end
    end
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
