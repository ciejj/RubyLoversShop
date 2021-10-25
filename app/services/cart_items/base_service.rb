# frozen_string_literal: true

require 'dry/monads'

module CartItems
  class BaseService
    include Dry::Monads[:result, :do]

    private

    def get_cart_item(id, user)
      cart_item = CartItem.find_by(id: id, user: user)

      if cart_item
        Success(cart_item)
      else
        Failure('Incorrect Cart Item')
      end
    end

    def destroy(cart_item)
      cart_item.destroy

      if cart_item.destroyed?
        Success('Cart Item deleted')
      else
        Failure('Cart Item could not be deleted')
      end
    end
  end
end
