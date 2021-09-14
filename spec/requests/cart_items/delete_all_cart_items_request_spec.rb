# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/cart_items', type: :request do
  describe 'DELETE /cart_items' do
    subject(:request_call) { delete '/cart_items' }

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
