# frozen_string_literal: true

module Payments
  class StateService
    include AASM
    attr_reader :payment

    def initialize(payment)
      @payment = payment
      if payment.state.nil?
        update_payment_state
      else
        aasm.current_state = payment.state.to_sym
      end
    end

    aasm whiny_transitions: false do
      state :pending, initial: true
      state :failed, :completed

      event :fail do
        transitions from: :pending, to: :failed
      end

      event :complete do
        transitions from: :pending, to: :completed
      end

      after_all_transitions :update_payment_state
    end

    def possible_events
      aasm.events(possible: true).map(&:name)
    end

    private

    def update_payment_state
      payment.update!(state: aasm.to_state)
    end
  end
end
