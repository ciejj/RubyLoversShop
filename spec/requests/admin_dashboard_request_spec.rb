require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :request do
  let!(:user) { create(:user) }
  let!(:administrator) { create(:administrator) }

  describe 'GET /admin' do

    context 'when not logged in' do
      it 'redirects to root path' do
        get '/admin'
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You are not authorized.')
      end
    end

    context 'when logged in as User' do
      it 'redirects to root path' do
        login_user(user)
        get "/admin"
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('You are not authorized.')
      end
    end

    context 'when logged in as Admin' do
      let!(:product_1)  { create(:product, name: 'product_1') }
      let!(:product_2)  { create(:product, name: 'product_2') }
      before do
        login_administrator(administrator)
      end

      it 'is possible to access admin root path' do
        get '/admin'
        expect(response.body).to include('Admin Panel')
      end

      it 'is possible to access admin root path' do
        get '/admin/products'
        expect(response.body).to include(product_1.name)
        expect(response.body).to include(product_2.name)
      end


    end
  end
end
