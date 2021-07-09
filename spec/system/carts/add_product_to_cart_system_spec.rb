# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cart - Adding Product', type: :system do
  let!(:product) { create(:product) }

  context 'when logged in as user' do
    before do
      login_as(create(:user), scope: :user)
    end

    context 'when visiting homepage' do
      before do
        visit '/'
        click_button 'Add to Cart'
      end

      it 'adds product to Cart' do
        click_link('Cart', exact: true)
        expect(page).to have_content('Shopping Cart')
          .and have_content(product.name.to_s)
      end

      it 'displays notice about product added to cart' do
        expect(page).to have_content("Added #{product.name} to the cart")
      end
    end

    context 'when visiting product\'s page' do
      before do
        visit '/'
        click_on product.name.to_s
        click_button 'Add to Cart'
      end

      it 'displays notice about product added to cart' do
        expect(page).to have_content("Added #{product.name} to the cart")
      end

      it 'adds product to Cart' do
        click_link('Cart', exact: true)
        expect(page).to have_content product.name
      end
    end
  end

  context 'when not logged in' do
    before do
      visit '/'
    end

    it 'does not display <<Add to cart>> buttons on home page' do
      expect(page).not_to have_content 'Add to Cart'
    end

    it 'does not display Cart button' do
      expect(page).not_to have_button 'Cart'
    end

    it 'does not display add to cart button on the product\'s page' do
      click_on product.name.to_s
      expect(page).not_to have_content 'Add to Cart'
    end
  end
end
