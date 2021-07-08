# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  def total
    line_items.inject(0) { |sum, item| item.total_price + sum }
  end

  delegate :empty?, to: :line_items
end
