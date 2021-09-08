# frozen_string_literal: true

class CartItemDecorator < Draper::Decorator
  delegate_all
  decorates_association :product
end
