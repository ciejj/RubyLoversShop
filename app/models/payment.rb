class Payment < ApplicationRecord
  belongs_to :order

  include AASM

  aasm do
    state :pending, initial: true
    state :failed, :completed

    event :fail do
      transitions from: :pending, to: :failed
    end

    event :complete do
      transitions from: :pending, to: :completed
    end
  end
end
