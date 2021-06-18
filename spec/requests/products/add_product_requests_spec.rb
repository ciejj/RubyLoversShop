# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /admin/prodcts/create', type: :request do
  context 'when logged in as administrator' do
    before do
      login_as(create(:administrator), scope: :administrator)
    end

    context 'with valid parameters' do
      let(:product_params) { attributes_for(:product) }

      it 'adds a product' do
        expect do
          post admin_products_path, params: { product: product_params }
        end.to change(Product, :count).by(1)
      end
    end

    context 'with missing price' do
      let(:product_name) { 'product_without_price' }

      it 'does not add a product' do
        expect do
          post admin_products_path, params: { product: { name: product_name } }
        end.not_to change(Product, :count)
      end
    end

    context 'with missing name' do
      let(:product_price) { 'product_without_name' }

      it 'does not add a product' do
        expect do
          post admin_products_path, params: { product: { price: product_price } }
        end.not_to change(Product, :count)
      end
    end
  end

  context 'when user is logged in' do
    let(:product_params) { attributes_for(:product) }

    before do
      login_as(create(:user), scope: :user)
    end

    it 'does not add add a product' do
      expect do
        post admin_products_path, params: { product: product_params }
      end.not_to change(Product, :count)
    end
  end

  context 'when not logged in' do
    let(:product_params) { attributes_for(:product) }

    it 'does not add add a product' do
      expect do
        post admin_products_path, params: { product: product_params }
      end.not_to change(Product, :count)
    end
  end
end
