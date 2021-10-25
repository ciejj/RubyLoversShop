# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/cart_items', type: :request do
  describe 'DELETE /cart_items' do
    subject(:request_call) { delete '/cart_items' }

    let!(:user1) { create(:user) }

    before do
      create(:cart_item, user: user1)
      create(:cart_item, user: user1)
    end

    context 'when cart items belongs to the logged in user' do
      before do
        login_as(user1, scope: :user)
      end

      it 'removes cart items' do
        expect do
          request_call
        end.to change(user1.cart_items, :count).by(-2)
      end
    end

    context 'when logged in user has no cart items' do
      let!(:user2) { create(:user) }

      before do
        login_as(user2, scope: :user)
      end

      it 'does not remove any cart items' do
        expect do
          request_call
        end.not_to change(CartItem, :count)
      end
    end

    context 'when logged in as user' do
      let!(:user) { create(:user) }

      before do
        login_as(user, scope: :user)
        create(:cart_item, user: user)
        create(:cart_item, user: user)
      end

      it 'removes Cart Items' do
        expect do
          request_call
        end.to change(user.cart_items, :count).by(-2)
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
