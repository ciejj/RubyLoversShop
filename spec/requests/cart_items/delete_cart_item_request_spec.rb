# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/cart_items', type: :request do
  describe 'DELETE /cart_item/:id' do
    subject(:request_call) { delete "/cart_items/#{cart_item.id}" }

    let!(:user1) { create(:user) }
    let!(:cart_item) { create(:cart_item, user: user1) }

    context 'when cart item belongs to logged in user' do
      before do
        login_as(user1, scope: :user)
      end

      it 'removes cart item with quantity = 1' do
        expect do
          request_call
        end.to change(user1.cart_items, :count).by(-1)
      end

      it 'removes Cart Item with quantity = 5' do
        cart_item.update(quantity: 5)
        expect do
          request_call
        end.to change(user1.cart_items, :count).by(-1)
      end
    end

    context 'when cart does not belong to logged in user' do
      let!(:user2) { create(:user) }

      before do
        login_as(user2, scope: :user)
      end

      it 'does not remove cart item with quantity = 1' do
        expect do
          request_call
        end.not_to change(user1.cart_items, :count)
      end

      it 'removes Cart Item with quantity = 5' do
        cart_item.update(quantity: 5)
        expect do
          request_call
        end.not_to change(user1.cart_items, :count)
      end
    end

    context 'when not logged in' do
      it 'does not remove Cart Items' do
        expect do
          request_call
        end.not_to change(CartItem, :count)
      end
    end
  end
end
