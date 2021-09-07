# frozen_string_literal: true

class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def total_price
    product.price
  end
end
