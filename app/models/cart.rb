# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def total
    line_items.inject(0) { |sum, item| item.total_price + sum }
  end

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)

    line_items.build(product_id: product.id) unless current_item
  end
end
