# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cart - Checkout', type: :system do
  before { create(:product) }

  context 'when logged in as user' do
    before do
      login_as(create(:user), scope: :user)
    end

    context 'with product in the cart' do
      before do
        visit '/'
        click_button 'Add to Cart'
        click_link('Cart', exact: true)
        click_link('Checkout', exact: true)
      end

      it 'is placing a new order' do
        expect(page).to have_content('Order has been placed')
      end

      it 'redirects to root path' do
        expect(page).to have_current_path(root_path)
      end
    end
  end
end
