# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  enum state: { new: 'new', failed: 'failed', completed: 'completed' }, _suffix: :order
end
