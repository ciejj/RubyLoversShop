# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/cart_items', type: :request do
  describe 'POST /cart_items?quantity=' do
    subject(:request_call) do
      post '/cart_items', params: { product_id: product.id, quantity: quantity }
    end

    let!(:product) { create(:product) }
    let(:quantity) { 2 }

    context 'when logged in as user' do
      let!(:user) { create(:user) }

      before do
        login_as(user, scope: :user)
      end

      context 'when Cart Item does not exist' do
        it 'creates new CartItem' do
          expect do
            request_call
          end.to change(CartItem, :count).by(1)
        end
      end

      context 'when Cart Item already exist' do
        let!(:cart_item) { create(:cart_item, product: product, user: user, quantity: 3) }

        it 'increases the quantity of existing Cart Item by quantity' do
          expect do
            request_call
          end.to change { cart_item.reload.quantity }.by(quantity)
        end
      end
    end

    context 'when not logged in' do
      it 'does not create CartItem' do
        expect do
          request_call
        end.not_to change(CartItem, :count)
      end
    end
  end
end
