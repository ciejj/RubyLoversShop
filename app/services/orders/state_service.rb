# frozen_string_literal: true

module Orders
  class StateService
    include AASM
    attr_reader :order

    def initialize(order)
      @order = order
      aasm.current_state = order.state.to_sym
    end

    aasm whiny_transitions: false do
      state :new, initial: true
      state :failed, :completed

      event :fail do
        transitions from: :new, to: :failed
      end

      event :complete do
        transitions from: :new, to: :completed, guards: %i[payment_completed? shipment_shipped?]
      end

      after_all_transitions :update_order_state
    end

    def permitted_events
      aasm.events(permitted: true).map(&:name)
    end

    private

    def update_order_state
      order.update!(state: aasm.to_state)
    end

    def payment_completed?
      Payments::StateService.new(order.payment).completed?
    end

    def shipment_shipped?
      Shipments::StateService.new(order.shipment).shipped?
    end
  end
end
