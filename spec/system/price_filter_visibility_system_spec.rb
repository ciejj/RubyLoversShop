# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Price Filter Visibility', type: :system do
  let!(:category) { create(:category) }
  let!(:brand) { create(:brand) }
  let!(:price_range1) { create(:price_range, min: 0, max: 10) }
  let!(:price_range2) { create(:price_range, min: 11, max: 20) }

  context 'when no filters are applied' do
    it 'does not display Price Ranges filter' do
      visit '/'

      expect(page).to have_no_css('h4.my-4', text: 'Price Ranges')
        .and have_no_css('.form-check-label', text: price_range1.name)
        .and have_no_css('.form-check-label', text: price_range2.name)
    end
  end

  context 'when only Category filter is applied' do
    before do
      visit '/'
      click_on category.name
    end

    it 'displays Price Ranges filter' do
      expect(page).to have_css('h4.my-4', text: 'Price Ranges')
        .and have_css('.form-check-label', text: price_range1.name)
        .and have_css('.form-check-label', text: price_range2.name)
    end
  end

  context 'when only Brand filter is applied' do
    before do
      visit '/'
      click_on brand.name
    end

    it 'displays Price Ranges filter' do
      expect(page).to have_css('h4.my-4', text: 'Price Ranges')
        .and have_css('.form-check-label', text: price_range1.name)
        .and have_css('.form-check-label', text: price_range2.name)
    end
  end

  context 'when Brand and Category filters are applied' do
    before do
      visit '/'
      click_on brand.name
      click_on category.name
    end

    it 'displays Price Ranges filter' do
      expect(page).to have_css('h4.my-4', text: 'Price Ranges')
        .and have_css('.form-check-label', text: price_range1.name)
        .and have_css('.form-check-label', text: price_range2.name)
    end
  end
end
