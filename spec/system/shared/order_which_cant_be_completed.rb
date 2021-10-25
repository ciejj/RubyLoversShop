# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'Order which can\'t be completed', type: :system do |payment_state, shipment_state|
  context "when payments is '#{payment_state}' and shipment is \'#{shipment_state}\'" do
    before do
      order.payment.update(state: payment_state)
      order.shipment.update(state: shipment_state)
    end

    it 'changes it\'s state to \'failed\' when Fail button is pressed' do
      within '.order-events' do
        click_link 'Fail'
      end
      expect(page).to have_css('.order-state', text: 'failed')
    end

    it 'does not display \'Complete\' button' do
      expect(page).not_to have_css('.complete-order', text: 'Complete')
    end
  end
end
