# frozen_string_literal: true

require 'dry/monads'

module CartItems
  class DeleteSingle < BaseService
    include Dry::Monads[:result, :do]

    def call(id:, user:)
      cart_item = yield get_cart_item(id, user)
      yield destroy(cart_item)

      Success('Product removed')
    end
  end
end
