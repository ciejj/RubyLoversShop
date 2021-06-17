# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  context 'when admin is logged in' do
    before do
      login_as(create(:administrator))
    end

    context 'with valid attributes' do
      let(:product_params) { attributes_for(:product) }

      it 'adds a product' do
        expect do
          post admin_products_path, params: { product: product_params }
        end.to change(Product, :count).by(1)
      end
    end

    context 'with missing price attribute' do
      let(:product_name) { 'product_without_price' }

      it 'does not add a product' do
        expect do
          post admin_products_path, params: { product: { name: product_name } }
        end.not_to change(Product, :count)
      end
    end

    context 'with missing name attribute' do
      let(:product_price) { 'product_without_name' }

      it 'does not add a product' do
        expect do
          post admin_products_path, params: { product: { price: product_price } }
        end.not_to change(Product, :count)
      end
    end
  end
end
