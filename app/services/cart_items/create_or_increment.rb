# frozen_string_literal: true

require 'dry/monads'

module CartItems
  class CreateOrIncrement
    include Dry::Monads[:result, :do]

    DEFAULT_QUANTITY = 1

    def call(product_id:, quantity:, user:)
      product = yield find_product(product_id)
      new_quantity = yield get_quantity(quantity)
      cart_item = CartItem.find_by(product_id: product_id, user: user)

      if cart_item
        yield increase_quantity(cart_item, new_quantity)
      else
        yield create_cart_item(product_id, user, new_quantity)
      end
      Success("Added #{product.name} to the cart")
    end

    private

    def find_product(id)
      product = Product.find(id)

      if product
        Success(product)
      else
        Failure('Product does not exist')
      end
    end

    def get_quantity(quantity)
      new_quantity = quantity ? quantity.to_i : DEFAULT_QUANTITY

      if new_quantity
        Success(new_quantity)
      else
        Failure('Quantity can\'t be determined')
      end
    end

    def increase_quantity(cart_item, new_quantity)
      cart_item.quantity += new_quantity
      if cart_item.save
        Success(cart_item)
      else
        Failure('Increasing number of products failed')
      end
    end

    def create_cart_item(product_id, user, new_quantity)
      cart_item = CartItem.create(product_id: product_id, user: user, quantity: new_quantity)
      if cart_item
        Success(cart_item)
      else
        Failure('Adding product to cart failed')
      end
    end
  end
end
