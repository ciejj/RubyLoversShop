# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  has_one_attached :main_image
  belongs_to :category, optional: true
  belongs_to :brand, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
end
