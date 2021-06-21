# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PATCH /admin/prodcts/:id', type: :request do
  let!(:product) { create(:product) }
  let(:new_name) { 'new_product_name' }
  let(:new_price) { 123_456 }

  context 'when logged in as administrator' do
    let!(:administrator) { create(:administrator) }

    before do
      login_as(administrator, scope: :administrator)
    end

    context 'with valid parameters' do
      before do
        patch admin_product_url(product), params: { product:
        { name: new_name, price: new_price } }
      end

      it 'update product\'s name' do
        product.reload
        expect(product.name).to eq(new_name)
      end

      it 'update product\'s price' do
        product.reload
        expect(product.price).to eq(new_price)
      end
    end

    context 'with empty product\'s price' do
      it 'does not update a product' do
        patch admin_product_url(product), params: { product:
                                          { price: '' } }

        product.reload
        expect(product.price).not_to eq('')
      end
    end

    context 'with empty product\'s name' do
      it 'does not update a product' do
        patch admin_product_url(product), params: { product:
                                          { name: '' } }

        product.reload
        expect(product.name).not_to eq('')
      end
    end
  end

  context 'when logged in as user' do
    let!(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
    end

    context 'with valid parameters' do
      before do
        patch admin_product_url(product), params: { product:
        { name: new_name, price: new_price } }
      end

      it 'doeas not update product\'s name' do
        product.reload
        expect(product.name).not_to eq(new_name)
      end

      it 'does not update product\'s price' do
        product.reload
        expect(product.price).not_to eq(new_price)
      end
    end
  end

  context 'when not logged in' do
    context 'with valid parameters' do
      before do
        patch admin_product_url(product), params: { product:
        { name: new_name, price: new_price } }
      end

      it 'doeas not update product\'s name' do
        product.reload
        expect(product.name).not_to eq(new_name)
      end

      it 'does not update product\'s price' do
        product.reload
        expect(product.price).not_to eq(new_price)
      end
    end
  end
end
