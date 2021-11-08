# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/', type: :request do
  describe 'GET /' do
    subject(:request_call) { get "/#{params}" }
    let!(:price_range1) { create(:price_range, min: 0, max: 10) }
    let!(:price_range2) { create(:price_range, min: 11, max: 20) }
    let!(:product1) { create(:product, price: 5) }
    let!(:product2) { create(:product, price: 15) }
    let!(:product3) { create(:product, price: 25) }

    context 'when no price filters are applied' do
      let(:params) { '' }

      it 'returns all products' do
        request_call
        expect(response.body).to include(product1.name)
        expect(response.body).to include(product2.name)
        expect(response.body).to include(product3.name)
      end
    end

    context 'when one price filter value is passed' do
      let(:params) { "?price_range_ids[]=#{price_range1.id}" }

      it 'returns a product from selected price range' do
        request_call
        expect(response.body).to include(product1.name)
      end

      it 'does not return products out of selected price range' do
        request_call
        expect(response.body).not_to include(product2.name)
        expect(response.body).not_to include(product3.name)
      end
    end

    context 'when two price filter values are passed' do
      let(:params) { "?price_range_ids[]=#{price_range1.id}&price_range_ids[]=#{price_range2.id}" }

      it 'returns products from selected price range' do
        request_call
        expect(response.body).to include(product1.name)
        expect(response.body).to include(product2.name)
      end

      it 'does not return products out of selected price range' do
        request_call
        expect(response.body).not_to include(product3.name)
      end
    end
  end
end
