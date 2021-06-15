require 'rails_helper'

RSpec.describe 'POST /admin/products', type: :request do
  before do
    login_as(create(:administrator))
  end

  context 'when attributes are valid' do
    it 'creates new product' do 
      post '/admin/products', params: {
        product: { name: 'new_product', price: '100' }
      }

      expect(Product.count).to eq(1)
    end
  end

  context 'when attributes are invalid' do
    it 'does not create a new product without a name' do
      post '/admin/products', params: {
        product: { price: '100' }
      }

      expect(Product.count).to eq(0)
    end

    it 'does not create a new product without a price' do
      post '/admin/products', params: {
        product: { name: 'new_product' }
      }

      expect(Product.count).to eq(0)
    end
  end
end
