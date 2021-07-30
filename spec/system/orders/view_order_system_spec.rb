# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Viewing Order', type: :system do
  let!(:administrator) { create(:administrator) }
  let!(:order) { create(:order) }
  let!(:order_item) { create(:order_item, order: order) }

  context 'when logged in as administrator' do
    before do
      login_as(administrator, scope: :administrator)
      visit '/admin'
      click_link 'Orders'
      click_link 'view'
    end

    it 'displays Order\'s details' do
      expect(page).to have_css('.order-id', text: order.id)
        .and have_css('.order-state', text: order.state)
        .and have_css('.order-user', text: order.user.email)
        .and have_css('.order-item-name', text: order_item.product.name)
        .and have_css('.order-total', text: order.total)
    end
  end
end
