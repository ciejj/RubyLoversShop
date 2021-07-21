# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Viewing Products Index on Admin Dashboard', type: :system do
  let!(:administrator) { create(:administrator) }
  let!(:product1)  { create(:product, name: 'product1') }
  let!(:product2)  { create(:product, name: 'product2') }

  context 'when logged in as administrator' do
    before do
      login_as(administrator, scope: :administrator)
      visit '/admin'
      click_link 'Products'
    end

    it 'is possible to access Products index' do
      expect(page).to have_current_path('/admin/products')
    end

    it 'displays all Products' do
      expect(page).to have_css('.product-name', text: product1.name)
        .and have_css('.product-name', text: product2.name)
    end
  end
end
