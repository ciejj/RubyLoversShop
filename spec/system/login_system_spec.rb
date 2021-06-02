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

    it 'user can reset password' do
      visit '/'
      click_on('Log In')
      click_on('Forgot Password?')
      fill_in 'user_email', with: user.email
      find('input[name="commit"]').click
      expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')
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
      fill_in 'user_email', with: 'fake_email@example.com'
      fill_in 'user_password', with: 'wrong_password'
      find('input[name="commit"]').click
      expect(page).to have_content('Invalid Email or password')
    end

    it 'user cannot reset password' do
      visit '/'
      click_on('Log In')
      click_on('Forgot Password?')
      fill_in 'user_email', with: 'fake_email@example.com'
      find('input[name="commit"]').click
      expect(page).to have_content('Email not found')
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
