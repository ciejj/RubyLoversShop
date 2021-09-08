# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Clicking \'Empty Cart\' button at Cart page', type: :system do
  let!(:user) { create(:user) }
  let!(:cart_item) { create(:cart_item, user: user) }
  let!(:cart_item2) { create(:cart_item, user: user) }

  context 'when logged in as user' do
    before do
      login_as(user, scope: :user)
      visit '/cart'
      click_link('Empty Cart', exact: true)
    end

    it 'displays notice about emptied cart' do
      expect(page).to have_content('Cart has been emptied')
    end

    it 'removes all products from the cart' do
      click_link('Cart', exact: true)
      expect(page).to have_no_content(cart_item.product.name.to_s)
        .and have_no_content(cart_item2.product.name.to_s)
    end
  end
end
