require 'rails_helper'

RSpec.describe 'Login Page', type: :system do
  let!(:user) { create(:user) }

  context 'when providing valid details' do
    it 'user can Log In' do
      visit '/'
      click_on('Log In')
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'password'
      find('input[name="commit"]').click
      expect(page).to have_content('Signed in successfully')
    end
  end

  context 'when providing invalid details' do
    it 'user cannot Log In with invalid password' do
      visit '/'
      click_on('Log In')
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: 'wrong_password'
      find('input[name="commit"]').click
      expect(page).to have_content('Invalid Email or password')
    end

    it 'user cannot Log In with invalid email' do
      visit '/'
      click_on('Log In')
      fill_in 'user_email', with: 'fake_exmail@example.com'
      fill_in 'user_password', with: 'wrong_password'
      find('input[name="commit"]').click
      expect(page).to have_content('Invalid Email or password')
    end
  end



  context 'when visitng the Home Page' do 
    it 'Log In button is visible' do
      visit '/'

      expect(page).to have_link('Log In')
    end
  end

  context 'when visitng the Sign Up Page' do 
    it 'Log In button is visible' do
      visit '/'
      click_on('Sign Up')

      expect(page).to have_link('Log In')
    end
  end
 
end
