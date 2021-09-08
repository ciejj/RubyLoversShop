# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Clicking \'Add to Cart\' button on the Homepage', type: :system do
  let!(:product) { create(:product) }
  let!(:user) { create(:user) }

  context 'when logged in as user' do
    before do
      login_as(user, scope: :user)
    end

    context 'without any copy of a product Product is not in the cart' do
      before do
        visit '/'
        click_on product.name
        click_button 'Add to Cart'
      end

      it 'adds specified number of products to Cart' do
        click_link('Cart', exact: true)
        expect(page).to have_css('.cart_item-name', text: product.name.to_s)
          .and have_css('.cart_item-quantity', text: 1)
      end

      it 'displays notice about product added to cart' do
        expect(page).to have_content("Added #{product.name} to the cart")
      end
    end

    context 'with a copy of a product Product is in the cart' do
      let!(:cart_item) { create(:cart_item, product: product, user: user, quantity: 1) }

      before do
        visit '/'
        click_button 'Add to Cart'
      end

      it 'adds exactly one copy of a product to Cart' do
        click_link('Cart', exact: true)
        expect(page).to have_css('.cart_item-name', text: product.name.to_s)
          .and have_css('.cart_item-quantity', text: (cart_item.quantity + 1).to_s)
      end

      it 'displays notice about product added to cart' do
        expect(page).to have_content("Added #{product.name} to the cart")
      end
    end
  end

  context 'when not logged in' do
    before do
      visit '/'
    end

    it 'does not display \'Add to cart\' button on home page' do
      expect(page).not_to have_content 'Add to Cart'
    end

    it 'does not display \'Cart button\'' do
      expect(page).not_to have_button 'Cart'
    end
  end
end
