require 'rails_helper'

RSpec.describe 'Products', type: :request do
  before do
    login_as(create(:administrator))
  end

  describe 'POST /admin/products' do
    let(:product) { create(:product) }

    context 'when attributes are valid' do
      before do
        post '/admin/products', params: {
          product: { name: product.name, price: product.price }
        }
      end

      it 'redirects to admin/products' do
        expect(response).to redirect_to(admin_products_path) 
      end

      it 'adds new product' do
        follow_redirect!
        expect(response.body).to include(product.name)
      end
    end
  end
end
