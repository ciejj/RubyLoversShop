# frozen_string_literal: true

RSpec.shared_examples 'Request not completing order', type: :request do |payment_state, shipment_state|
  context "when the payment is '#{payment_state}' and shipment is '#{shipment_state}'" do
    before do
      order.payment.update(state: payment_state)
      order.shipment.update(state: shipment_state)
    end

    it 'does not change the payment state' do
      expect do
        patch "/admin/orders/#{order.id}?event=complete"
        order.reload
      end.not_to change(order, :state)
    end
  end
end
