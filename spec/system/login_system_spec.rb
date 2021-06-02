require 'rails_helper'

RSpec.describe 'Login Page', type: :system do

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
