# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /prodcts/:id', type: :request do
  let!(:product) { create(:product) }

  context 'when logged in as user' do
    let!(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
      get "/products/#{product.id}"
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when not logged in' do
    before do
      get "/products/#{product.id}"
    end

    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
  end
end
