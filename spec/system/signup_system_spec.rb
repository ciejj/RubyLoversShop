# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign Up', type: :system do
  context 'when providing valide details' do
    before do
      visit '/'
      click_on 'Sign Up'
    end

    it 'allows user to create account' do
      fill_in 'user_email', with: 'john@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      find('input[name="commit"]').click
      expect(page).to have_content('You have signed up successfully')
    end
  end
end
