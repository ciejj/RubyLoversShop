# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Clicking \'Remove\' button on the Cart page', type: :system do
  let!(:user) { create(:user) }
  let!(:cart_item1) { create(:cart_item, user: user) }
  let!(:cart_item2) { create(:cart_item, user: user) }

  context 'when logged in as user with two products in the cart' do
    before do
      login_as(user, scope: :user)
      visit '/cart'
      find("#remove-#{cart_item1.id}").click
    end

    it 'removes product from the cart' do
      expect(page).to have_no_content(cart_item1.product.name.to_s)
    end

    it 'does not remove second product from the cart' do
      expect(page).to have_content(cart_item2.product.name.to_s)
    end
  end
end
