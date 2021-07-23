# frozen_string_literal: true

require 'rails_helper'
require_relative '../shared/request_restricted_to_administrators'

RSpec.describe 'GET /admin/orders', type: :request do
  let!(:administrator) { create(:administrator) }
  let!(:order1)  { create(:order) }
  let!(:order2)  { create(:order) }

  context 'when logged in as administrator' do
    before do
      login_as(administrator, scope: :administrator)
      get '/admin/orders'
    end

    it 'is possible to access orders index' do
      expect(response.body).to include('Admin Panel').and include('<h2>Orders</h2>')
    end

    it 'is displaying all orders' do
      expect(response.body).to include(order1.id.to_s).and include(order2.id.to_s)
    end
  end

  it_behaves_like 'request restricted to administrators' do
    let(:path) { '/admin/orders' }
  end
end
