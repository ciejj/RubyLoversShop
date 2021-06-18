# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Adding Product', type: :system do
  context 'when logged in as admin' do
    before do
      login_as(create(:administrator), scope: :administrator)
      visit admin_products_path
    end

    context 'with valid product attributes' do
      let(:product_params) { attributes_for(:product) }

      before do
        find('#add-product-button').click
        fill_in 'product_name', with: product_params[:name]
        fill_in 'product_price', with: product_params[:price]
        click_button 'Save Product'
      end

      it 'is successful' do
        expect(page).to have_content 'Product added successfully'
      end

      it 'shows new product on product_index' do
        expect(page).to have_content product_params[:name]
      end

      it 'shows new product on home page' do
        visit '/'
        expect(page).to have_content product_params[:name]
      end
    end

    context 'with missing price' do
      let(:product_name) { 'product_with_no_price' }

      before do
        find('#add-product-button').click
        fill_in 'product_name', with: product_name
        click_button 'Save Product'
      end

      it 'displays missing price error' do
        expect(page).to have_content 'Price can\'t be blank'
      end

      it 'does not add new product' do
        visit '/'
        expect(page).to have_no_content product_name
      end
    end

    context 'with missing name' do
      let(:product_price) { 1 }

      before do
        find('#add-product-button').click
        fill_in 'product_price', with: product_price
        click_button 'Save Product'
      end

      it 'displays missing name error' do
        expect(page).to have_content 'Name can\'t be blank'
      end

      it 'does not add new product' do
        visit '/'
        expect(page).to have_no_content product_price
      end
    end
  end

  context 'when logged in as user' do
    before do
      login_as(create(:user), scope: :user)
      visit admin_products_path
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
      visit admin_products_path
    end

    it 'redirects to root path' do
      expect(page).to have_current_path(root_path)
    end

    it 'displays unauthorized warning' do
      expect(page).to have_content('You are not authorized.')
    end
  end
end
