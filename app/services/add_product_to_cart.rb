# frozen_string_literal: true

require 'dry/monads'

class AddProductToCart
  include Dry::Monads[:result, :do]

  def call(product_id:, user_id:)
    product = yield find_product(product_id)
    cart_item = CartItem.find_by(product_id: product_id, user_id: user_id)

    if cart_item
      increase_quantity(cart_item)
    else
      create_cart_item(product_id, user_id)
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

  def increase_quantity(cart_item)
    cart_item.quantity += 1
    if cart_item.save
      Success(cart_item)
    else
      Failure('Increasing number of products failed')
    end
  end

  def create_cart_item(product_id, user_id)
    cart_item = CartItem.create(product_id: product_id, user_id: user_id)
    if cart_item
      Success(cart_item)
    else
      Failure('Adding product to cart failed')
    end
  end
end
