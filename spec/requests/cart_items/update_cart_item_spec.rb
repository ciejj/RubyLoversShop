# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/cart_items', type: :request do
  describe 'PATCH /cart_items/:id' do
    subject(:request_call) do
      patch "/cart_items/#{cart_item.id}", params: { cart_item: { quantity: quantity } }
    end

    let!(:user1) { create(:user) }
    let!(:cart_item) { create(:cart_item, user: user1) }

    context 'when cart item belongs to logged in user' do
      before do
        login_as(user1, scope: :user)
      end

      context 'with new quantity > 0' do
        let(:quantity) { 2 }

        it 'updates Cart Item\'s quantity' do
          expect do
            request_call
          end.to change { cart_item.reload.quantity }.to(quantity)
        end
      end

      context 'with new quantity = 0' do
        let(:quantity) { 0 }

        it 'deletes cart item' do
          expect do
            request_call
          end.to change(CartItem, :count).by(-1)
        end
      end

      context 'with new quantity < 0' do
        let(:quantity) { -1 }

        it 'does not change the cart item\'s quantity' do
          expect do
            request_call
          end.to change { cart_item.reload.quantity }.by(0)
        end
      end
    end

    context 'when cart item does not belong to logged in user' do
      let!(:user2) { create(:user) }

      before do
        login_as(user2, scope: :user)
      end

      context 'with new quantity > 0' do
        let(:quantity) { 2 }

        it 'does not change the cart item\'s quantity' do
          expect do
            request_call
          end.to change { cart_item.reload.quantity }.by(0)
        end
      end

      context 'with new quantity = 0' do
        let(:quantity) { 0 }

        it 'does not change the cart item\'s quantity' do
          expect do
            request_call
          end.to change { cart_item.reload.quantity }.by(0)
        end
      end

      context 'with new quantity < 0' do
        let(:quantity) { -1 }

        it 'does not change the cart item\'s quantity' do
          expect do
            request_call
          end.to change { cart_item.reload.quantity }.by(0)
        end
      end
    end

    context 'when not logged in' do
      context 'with new quantity > 0' do
        let(:quantity) { 2 }

        it 'does not change the cart item\'s quantity' do
          expect do
            request_call
          end.to change { cart_item.reload.quantity }.by(0)
        end
      end

      context 'with new quantity = 0' do
        let(:quantity) { 0 }

        it 'does not change the cart item\'s quantity' do
          expect do
            request_call
          end.to change { cart_item.reload.quantity }.by(0)
        end
      end

      context 'with new quantity < 0' do
        let(:quantity) { -1 }

        it 'does not change the cart item\'s quantity' do
          expect do
            request_call
          end.to change { cart_item.reload.quantity }.by(0)
        end
      end
    end
  end
end
