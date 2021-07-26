# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Viewing Orders on Adnim Dashboard', type: :system do
  let!(:administrator) { create(:administrator) }
  let!(:order1)  { create(:order) }
  let!(:order2)  { create(:order) }

  context 'when logged in as administrator' do
    before do
      login_as(administrator, scope: :administrator)
      visit '/admin'
      click_link 'Orders'
    end

    it 'is possible to access Orders index' do
      expect(page).to have_current_path('/admin/orders')
    end

    it 'displays all Orders' do
      expect(page).to have_css('.order-id', text: order1.id)
        .and have_css('.order-id', text: order2.id)
    end
  end
end
