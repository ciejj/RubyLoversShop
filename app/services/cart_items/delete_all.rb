# frozen_string_literal: true

require 'dry/monads'

module CartItems
  class DeleteAll
    include Dry::Monads[:result, :do]

    def call(user:)
      yield destroy_all(user)

      Success('Cart has been emptied')
    end

    private

    def destroy_all(user)
      user.cart_items.destroy_all

      if user.cart_items.empty?
        Success('Cart has been emptied')
      else
        Failure('Cart could not be emptied')
      end
    end
  end
end
