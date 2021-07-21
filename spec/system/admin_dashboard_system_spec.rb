# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Visiting Admin Dashboard', type: :system do
  let!(:user) { create(:user) }
  let!(:administrator) { create(:administrator) }

  context 'when logged in as administrator' do
    before do
      login_as(administrator, scope: :administrator)
      visit '/admin'
    end

    it 'is possible to access admin root path' do
      expect(page).to have_current_path('/admin')
    end
  end

  context 'when logged in as user' do
    before do
      login_as(user, scope: :user)
      visit '/admin'
    end

    it 'redirects to root path' do
      expect(page).to have_current_path(root_path)
    end

    it 'displays unauthorized warning' do
      expect(page).to have_content('You are not authorized.')
    end
  end

  context 'when not logged in' do
    before do
      visit '/admin'
    end

    it 'redirects to root path' do
      expect(page).to have_current_path(root_path)
    end

    it 'displays unauthorized warning' do
      expect(page).to have_content('You are not authorized.')
    end
  end
end
