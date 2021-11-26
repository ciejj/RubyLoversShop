# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /orders/billing_address', type: :request do
    
  subject(:request_call) do
    post '/orders/billing_address', params: {address: params}
  end

  let!(:product) { create(:product) }

  context 'when logged in as user' do
    let!(:user) { create(:user) }

    context 'with newly created order' do
      
      before do
        login_as(user, scope: :user)
        post '/cart_items', params: { product_id: product.id }
        post '/orders'
      end

      context 'when posting valid Address details' do
        let(:params) { attributes_for(:address) }
  
        it 'creates new Billing Address' do
          expect do
            request_call
          end.to change(Address, :count).by(1)
        end
      end
  
      context 'when posting invalid Address details' do
        let(:params) { attributes_for(:address, street_name1: '') }
  
        it 'does not create new Billing Address' do
          expect do
            request_call
          end.not_to change(Address, :count)
        end
      end
    end

    context 'without newly created order' do
    
      context 'when posting valid Address details' do
        let(:params) { attributes_for(:address) }
  
        it 'does not create Billing Address' do
          expect do
            request_call
          end.not_to change(Address, :count)
        end
      end
    end
  end
end
