# frozen_string_literal: true

module Shipments
  class StateService
    include AASM
    attr_reader :shipment

    def initialize(shipment)
      @shipment = shipment
      if shipment.state.nil?
        update_shipment_state
      else
        aasm.current_state = shipment.state.to_sym
      end
    end

    aasm whiny_transitions: false do
      state :pending, initial: true
      state :ready
      state :shipped
      state :canceled
      state :failed

      event :prepare do
        transitions from: :pending, to: :ready
      end

      event :cancel do
        transitions from: :pending, to: :canceled
      end

      event :ship do
        transitions from: :ready, to: :shipped, guard: :payment_completed?
      end

      event :fail do
        transitions from: :ready, to: :failed
      end

      after_all_transitions :update_shipment_state
    end

    def possible_events
      aasm.events(permitted: true).map(&:name)
    end

    private

    def update_shipment_state
      shipment.update!(state: aasm.to_state)
    end

    def payment_completed?
      Payments::StateService.new(shipment.order.payment).completed?
    end
  end
end
