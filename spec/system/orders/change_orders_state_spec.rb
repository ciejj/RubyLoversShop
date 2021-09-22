# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared/order_which_cant_be_completed'

RSpec.describe 'Changing Order\'s state', type: :system do
  let!(:administrator) { create(:administrator) }

  context 'when logged in as administrator' do
    let!(:order) { create(:order) }

    before do
      login_as(administrator, scope: :administrator)
      visit '/admin'
      click_link 'Orders'
      click_link 'view'
    end

    %w[pending failed completed].each do |payment_state|
      %w[pending ready cancelled failed].each do |shipment_state|
        it_behaves_like 'Order which can\'t be completed', payment_state, shipment_state
      end
    end

    context 'when payments is \'completed\' and shipment is \'shipped\'' do
      before do
        order.payment.update(state: 'completed')
        order.shipment.update(state: 'shipped')
        visit current_path
      end

      it 'changes it\'s state to \'failed\' when Fail button is pressed' do
        within '.order-events' do
          click_link 'Fail'
        end

        expect(page).to have_css('.order-state', text: 'failed')
      end

      it 'changes it\'s state to \'completed\' when Complete button is pressed' do
        within '.order-events' do
          click_link 'Complete'
        end

        expect(page).to have_css('.order-state', text: 'completed')
      end
    end
  end
end
