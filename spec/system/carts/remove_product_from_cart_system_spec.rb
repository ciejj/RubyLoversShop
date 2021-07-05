# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cart - Removing Products', type: :system do
  let!(:product) { create(:product) }

  context 'when logged in as user with a product in a cart' do
    before do
      login_as(create(:user), scope: :user)
      visit '/'
      click_button 'Add to Cart'
      click_link('Cart', exact: true)
    end

    context 'when <<Empty Cart>> button is clicked' do
      before do
        click_link('Empty Cart', exact: true)
      end

      it 'displays notice about product added to cart' do
        expect(page).to have_content('Cart has been emptied')
      end

      it 'removes all products from the cart' do
        click_link('Cart', exact: true)
        expect(page).not_to have_content(product.name.to_s)
      end
    end
  end
end
