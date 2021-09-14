# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /orders', type: :request do
  context 'when logged in as user' do
    let!(:product) { create(:product) }
    let!(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
    end

    context 'with a product in the cart' do
      before do
        post '/cart_items', params: { product_id: product.id }
      end

      it 'creates new Order' do
        expect do
          post '/orders'
        end.to change(Order, :count).by(1)
      end
    end

    context 'without a product in the cart' do
      it 'does not create new Order' do
        expect do
          post '/orders'
        end.not_to change(Order, :count)
      end
    end
  end
end
