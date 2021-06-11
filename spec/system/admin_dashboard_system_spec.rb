require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :system do
  let!(:user) { create(:user) }
  let!(:administrator) { create(:administrator) }

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

  context 'when logged in as administrator' do
    before do
      visit '/administrators/sign_in'
      fill_in 'administrator_email', with: administrator.email
      fill_in 'administrator_password', with: 'password'
      find('input[name="commit"]').click
      visit '/admin'
    end

    it 'is possible to access admin root path' do
      expect(page).to have_current_path('/admin')
    end
  end
end
