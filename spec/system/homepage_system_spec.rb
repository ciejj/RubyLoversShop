# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home Page', type: :system do
  let!(:category) { create(:category) }
  let!(:brand) { create(:brand) }
  let!(:product_c_b)  { create(:product, name: 'product_1_1', category: category, brand: brand) }
  let!(:product_c)  { create(:product, name: 'product_1_2', category: category) }
  let!(:product_b)  { create(:product, name: 'product_2_1', brand: brand) }

  context 'when no filters are applied' do
    it 'displays all available Products' do
      visit '/'

      expect(page).to have_css('h4.card-title', text: product_c_b.name)
        .and  have_css('h4.card-title', text: product_c.name)
        .and  have_css('h4.card-title', text: product_b.name)
    end
  end

  context 'when only Category filter is applied' do
    before do
      visit '/'
      click_on category.name
    end

    it 'displays only Products from chosen Category' do
      expect(page).to have_css('h4.card-title', text: product_c_b.name)
        .and  have_css('h4.card-title', text: product_c.name)
    end

    it 'does not display Products not from chosen Category' do
      expect(page).not_to have_css('h4.card-title', text: product_b.name)
    end
  end

  context 'when only Brand filter is applied' do
    before do
      visit '/'
      click_on brand.name
    end

    it 'displays only Products from chosen Brand' do
      expect(page).to have_css('h4.card-title', text: product_c_b.name)
        .and  have_css('h4.card-title', text: product_b.name)
    end

    it 'does not display Products not from chosen Brand' do
      expect(page).not_to have_css('h4.card-title', text: product_c.name)
    end
  end

  context 'when Brand and Category filters are applied' do
    before do
      visit '/'
      click_on brand.name
      click_on category.name
    end

    it 'displays only Products from chosen Brand and Category' do
      expect(page).to have_css('h4.card-title', text: product_c_b.name)
    end

    it 'does not display Products with matching Category only' do
      expect(page).not_to have_css('h4.card-title', text: product_c.name)
    end

    it 'does not display Products with matching Brand only' do
      expect(page).not_to have_css('h4.card-title', text: product_b.name)
    end
  end
end
