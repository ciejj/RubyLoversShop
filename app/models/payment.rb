# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :order
  has_one :address, as: :addressable, dependent: :destroy
end
