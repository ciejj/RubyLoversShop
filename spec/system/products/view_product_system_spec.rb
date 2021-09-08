# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Viewing Product's page", type: :system do
  let!(:product) { create(:product).decorate }

  context 'when logged in as user' do
    before do
      login_as(create(:user), scope: :user)
      visit '/'
      click_link product.name
    end

    it "displays Product's details" do
      expect(page).to have_css('.product-name', text: product.name)
        .and have_css('.product-price', text: product.price)
        .and have_css('.product-description', text: product.description)
    end

    it "displays Product's image" do
      visit page.find('.product-img')[:src]
      expect(page.status_code).to eq 200
    end

    it "displays 'Add to Cart' button" do
      expect(page).to have_button('Add to Cart')
    end
  end

  context 'when not logged in' do
    before do
      visit '/'
      click_link product.name
    end

    it "displays Product's details" do
      expect(page).to have_css('.product-name', text: product.name)
        .and have_css('.product-price', text: product.price)
        .and have_css('.product-description', text: product.description)
    end

    it "displays Product's image" do
      visit page.find('.product-img')[:src]
      expect(page.status_code).to eq 200
    end

    it "does not display 'Add to Cart' button" do
      expect(page).not_to have_button('Add to Cart')
    end
  end
end
