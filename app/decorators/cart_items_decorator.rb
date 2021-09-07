# frozen_string_literal: true

class CartItemsDecorator < Draper::CollectionDecorator
  def total
    object.inject(0) { |sum, item| item.decorate.subtotal + sum }
  end
end
