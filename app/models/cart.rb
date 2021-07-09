# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  def total
    cart_items.inject(0) { |sum, item| item.total_price + sum }
  end

  delegate :empty?, to: :cart_items
end
