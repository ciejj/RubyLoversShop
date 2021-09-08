# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CartItems', type: :request do
  describe 'POST /cart_items' do
    context 'when logged in as user' do
      let!(:product) { create(:product) }
      let!(:user) { create(:user) }

      before do
        login_as(user, scope: :user)
      end

      context 'when Cart Item does not exist' do
        it 'creates new CartItem' do
          expect do
            post '/cart_items', params: { product_id: product.id }
          end.to change(CartItem, :count).by(1)
        end
      end

      context 'when Cart Item already exist' do
        let!(:cart_item) { create(:cart_item, product: product, user: user, quantity: 1) }

        it 'increases the quantity of existing Cart Item' do
          expect do
            post '/cart_items', params: { product_id: product.id }
          end.to change { cart_item.reload.quantity }.from(1).to(2)
        end
      end
    end

    context 'when not logged in' do
      let!(:product) { create(:product) }

      it 'does not create CartItem' do
        expect do
          post '/cart_items', params: { product_id: product.id }
        end.not_to change(CartItem, :count)
      end
    end
  end
end
