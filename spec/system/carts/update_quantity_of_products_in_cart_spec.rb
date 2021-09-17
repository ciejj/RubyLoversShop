# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Changing Product\'s quantity on the Cart page', type: :system do
  subject(:quantity_update) do
    select quantity.to_s, from: 'cart_item_quantity'
  end

  before do
    driven_by(:selenium_chrome_headless)
  end

  let!(:user) { create(:user) }
  let!(:cart_item) { create(:cart_item, user: user) }

  context 'when logged in as user' do
    before do
      login_as(user, scope: :user)
      visit '/cart'
    end

    context 'with new quantiy > 0' do
      let(:quantity) { 3 }

      before do
        quantity_update
      end

      it 'changes product\'s quantity' do
        expect(page).to have_css('.cart_item-quantity', text: quantity.to_s)
      end

      it 'changes product\'s SubTotal value' do
        expect(page).to have_css('.cart_item-subtotal', text: cart_item.product.price * quantity.to_i)
      end
    end

    context 'with new quantiy = 0' do
      let(:quantity) { 0 }

      before do
        quantity_update
      end

      it 'removes product from cart' do
        expect(page).not_to have_css('.cart_item-name', text: cart_item.product.name)
      end
    end
  end
end
