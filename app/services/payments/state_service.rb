# frozen_string_literal: true

module Payments
  class StateService
    include AASM
    attr_reader :payment

    def initialize(payment)
      @payment = payment
      aasm.current_state = payment.state.to_sym
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

    def permitted_events
      aasm.events(permitted: true).map(&:name)
    end

    private

    def update_payment_state
      payment.update!(state: aasm.to_state)
    end
  end
end
