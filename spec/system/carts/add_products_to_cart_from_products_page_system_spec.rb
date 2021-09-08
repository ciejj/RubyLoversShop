# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Clicking \'Add to Cart\' button on the Product\'s page', type: :system do
  let!(:product) { create(:product) }
  let!(:user) { create(:user) }
  let(:quantity) { 3 }

  context 'when logged in as user' do
    before do
      login_as(user, scope: :user)
    end

    context 'without any copy of a product Product is not in the cart' do
      before do
        visit '/'
        click_on product.name
        fill_in 'quantity', with: quantity
        click_button 'Add to Cart'
      end

      it 'adds specified number of product\'s copies to Cart' do
        click_link('Cart', exact: true)
        expect(page).to have_css('.cart_item-name', text: product.name.to_s)
          .and have_css('.cart_item-quantity', text: quantity.to_s)
      end

      it 'displays notice about product added to cart' do
        expect(page).to have_content("Added #{product.name} to the cart")
      end
    end

    context 'with a copy of a product Product is in the cart' do
      let!(:cart_item) { create(:cart_item, product: product, user: user, quantity: 1) }

      before do
        visit '/'
        click_on product.name
        fill_in 'quantity', with: quantity
        click_button 'Add to Cart'
      end

      it 'adds specified number of product\'s copies to Cart' do
        click_link('Cart', exact: true)
        expect(page).to have_css('.cart_item-name', text: product.name.to_s)
          .and have_css('.cart_item-quantity', text: (cart_item.quantity + quantity).to_s)
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

    it 'does not display add to cart button on the product\'s page' do
      click_on product.name.to_s
      expect(page).not_to have_content 'Add to Cart'
    end
  end
end
