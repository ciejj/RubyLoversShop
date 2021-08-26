# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared/administrators_request'

RSpec.describe 'GET /orders/:id', type: :request do
  let!(:order) { create(:order) }

  context 'when logged in as administrator' do
    let!(:administrator) { create(:administrator) }

    before do
      login_as(administrator, scope: :administrator)
    end

    it 'returns order\'s details' do
      get "/admin/orders/#{order.id}"
      expect(response.body).to include(order.id.to_s).and include(order.state)
        .and include(order.user.email).and include(order.order_items.first.product.name)
        .and include(order.total.to_s)
    end
  end

  it_behaves_like 'administrators request' do
    let(:path) { "/admin/orders/#{order.id}" }
    let(:request_method) { 'get' }
    let(:params) { {} }
  end
end
