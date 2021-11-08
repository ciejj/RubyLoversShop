# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Price Filter', type: :system do
  let!(:category) { create(:category) }
  let!(:price_range1) { create(:price_range, min: 0, max: 10) }
  let!(:price_range2) { create(:price_range, min: 11, max: 20) }
  let!(:product1) { create(:product, category: category, price: 5) }
  let!(:product2) { create(:product, category: category, price: 15) }

  context 'when one Price Range is selected' do
    before do
      visit '/'
      click_on category.name
      check "price-range-checkbox-#{price_range1.id}"
      find('#filter-button').click
    end

    it 'displays only a product from selected price range' do
      expect(page).to have_css('h4.card-title', text: product1.name)
    end

    it 'does not display any products from outside selected price range' do
      expect(page).to have_no_css('h4.card-title', text: product2.name)
    end
  end

  context 'when multiple Price Ranges are selected' do
    before do
      visit '/'
      click_on category.name
      check "price-range-checkbox-#{price_range1.id}"
      check "price-range-checkbox-#{price_range2.id}"
      find('#filter-button').click
    end

    it 'displays only products from selected price range' do
      expect(page).to have_css('h4.card-title', text: product1.name)
        .and have_css('h4.card-title', text: product2.name)
    end
  end

  context 'when no Price Range is selected' do
    before do
      visit '/'
      click_on category.name
      find('#filter-button').click
    end

    it 'displays all products' do
      expect(page).to have_css('h4.card-title', text: product1.name)
        .and have_css('h4.card-title', text: product2.name)
    end
  end
end
