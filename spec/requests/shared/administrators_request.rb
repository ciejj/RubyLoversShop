# frozen_string_literal: true

RSpec.shared_examples 'administrators request' do
  context 'when logged in as User' do
    let!(:user) { create(:user) }

    before do
      login_as(user, scope: :user)
      method(request_method).call(path)
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
      method(request_method).call(path)
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
