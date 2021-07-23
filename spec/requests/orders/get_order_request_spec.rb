# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /order/:id', type: :request do
  let!(:order) { create(:order) }
  let!(:order_item) { create(:order_item, order: order) }

  context 'when logged in as administrator' do
    let!(:administrator) { create(:administrator) }

    before do
      login_as(administrator, scope: :administrator)
    end

    it 'returns order\'s details' do
      get "/admin/orders/#{order.id}"
      expect(response.body).to include(order.id.to_s).and include(order.state)
        .and include(order.user.email).and include(order_item.product.name)
        .and include(order.total.to_s)
    end
  end

  context 'when logged in as User' do
    let!(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
      get "/admin/orders/#{order.id}"
    end

    it 'redirects to root path' do
      expect(response).to redirect_to(root_path)
    end

    it 'informs about lack of authorization' do
      follow_redirect!
      expect(response.body).to include('You are not authorized.')
    end
  end

  context 'when not logged in' do
    before do
      get "/admin/orders/#{order.id}"
    end

    it 'redirects to root path' do
      expect(response).to redirect_to(root_path)
    end

    it 'informs about lack of authorization' do
      follow_redirect!
      expect(response.body).to include('You are not authorized.')
    end
  end
end
