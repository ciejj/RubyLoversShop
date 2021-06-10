require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :system do
  let!(:user) { create(:user) }
  let!(:admin) { create(:admin) }

  context 'when not logged in' do
    before do
      visit 'admin'
    end

    it 'redirects to root path' do
      expect(page).to have_current_path(root_path)
    end

    it 'displays unauthorized warning' do
      expect(page).to have_content('You are not authorized.')
    end
  end

  context 'when logged in as user' do
    before do
      visit '/'
      click_on('Log In')
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      find('input[name="commit"]').click
      visit 'admin'
    end

    it 'redirects to root path' do
      expect(page).to have_current_path(root_path)
    end

    it 'displays unauthorized warning' do
      expect(page).to have_content('You are not authorized.')
    end
  end

  context 'when logged in as admin' do
    before do
      visit '/admins/sign_in'
      fill_in 'admin_email', with: admin.email
      fill_in 'admin_password', with: 'password'
      find('input[name="commit"]').click
      visit '/admin'
    end

    it 'is possible to access admin root path' do
      expect(page).to have_current_path(admin_root_path)
    end
  end
end
