# frozen_string_literal: true

require 'dry/monads'

module CartItems
  class CreateOrIncrement
    include Dry::Monads[:result, :do]

    def call(params:, user:)
      product = yield find_product(params[:product_id])
      quantity = yield get_quantity(params)
      cart_item = CartItem.find_by(product_id: product.id, user_id: user.id)

      if cart_item
        yield increase_quantity(cart_item, quantity)
      else
        yield create_cart_item(product.id, user.id, quantity)
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

    def get_quantity(params)
      quantity = if params[:quantity]
                   params[:quantity].to_i
                 else
                   1
                 end

      if quantity
        Success(quantity)
      else
        Failure('Quantity can\'t be determined')
      end
    end

    def increase_quantity(cart_item, quantity)
      cart_item.quantity += quantity
      if cart_item.save
        Success(cart_item)
      else
        Failure('Increasing number of products failed')
      end
    end

    def create_cart_item(product_id, user_id, quantity)
      cart_item = CartItem.create(product_id: product_id, user_id: user_id, quantity: quantity)
      if cart_item
        Success(cart_item)
      else
        Failure('Adding product to cart failed')
      end
    end
  end
end
