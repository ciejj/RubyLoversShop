# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  enum state: { new: 1, failed: 2, completed: 3 }, _suffix: :order
end
