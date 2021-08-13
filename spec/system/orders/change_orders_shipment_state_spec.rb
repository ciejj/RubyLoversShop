# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Changing Order\'s Shipment state', type: :system do
  let!(:administrator) { create(:administrator) }

  context 'when logged in as administrator' do
    before do
      create(:order)
      login_as(administrator, scope: :administrator)
      visit '/admin'
      click_link 'Orders'
      click_link 'view'
    end

    context 'when shipment is \'pending\'' do
      it 'changes the it\'s state to \'ready\' when Prepare button is pressed' do
        within '.shipment-events' do
          click_link 'Prepare'
        end

        expect(page).to have_css('.shipment-state', text: 'ready')
      end

      it 'changes the it\'s state to \'cancelled\' when Cancel button is pressed' do
        within '.shipment-events' do
          click_link 'Cancel'
        end

        expect(page).to have_css('.shipment-state', text: 'canceled')
      end
    end

    context 'when shipment is \'ready\'' do
      before do
        within '.shipment-events' do
          click_link 'Prepare'
        end
        within '.payment-events' do
          click_link 'Complete'
        end
      end

      it 'changes the it\'s state to \'shipped\' when Ship button is pressed if payment is completed' do
        within '.shipment-events' do
          click_link 'Ship'
        end

        expect(page).to have_css('.shipment-state', text: 'shipped')
      end

      it 'changes the it\'s state to \'failed\' when Fail button is pressed' do
        within '.shipment-events' do
          click_link 'Fail'
        end

        expect(page).to have_css('.shipment-state', text: 'failed')
      end
    end
  end
end
