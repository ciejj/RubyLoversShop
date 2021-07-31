# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Changing Order\'s Payment state', type: :system do
  let!(:administrator) { create(:administrator) }
  let!(:order) { create(:order) }

  context 'when logged in as administrator' do
    before do
      create(:order_item, order: order)
      login_as(administrator, scope: :administrator)
      visit '/admin'
      click_link 'Orders'
      click_link 'view'
    end

    it 'changes the payment state to \'complete\' when Complete button is pressed' do
      within '.payment-events' do
        click_link 'Complete'
      end
      expect(page).to have_css('.payment-state', text: 'completed')
    end

    it 'changes the payment state to \'failed\' when Failed button is pressed' do
      within '.payment-events' do
        click_link 'Fail'
      end
      expect(page).to have_css('.payment-state', text: 'failed')
    end
  end
end
