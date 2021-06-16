# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :system do
  context 'when creating a new product' do
    before do
      login_as(create(:administrator))
      visit admin_products_path
      find('#add-product-button').click
    end

    context 'with valid attributes' do
      let(:product_name) { 'new_product' }
      let(:product_price) { 100 }

      before do
        fill_in 'product_name', with: product_name
        fill_in 'product_price', with: product_price
        click_button 'Create Product'
      end

      it 'is created' do
        expect(page).to have_content 'Product added successfully'
      end

      it 'is visible on the admin index page' do
        expect(page).to have_content product_name
      end

      it 'is visible on the home page' do
        visit '/'
        expect(page).to have_content product_name
      end
    end

    context 'when the price is missing' do    
      let(:product_name) { 'product_with_no_price' }

      before do
        fill_in 'product_name', with: product_name
        click_button 'Create Product'
      end

      it 'displays an error' do
        expect(page).to have_content 'Price can\'t be blank'
      end

      it 'is not adding new product' do
        visit '/'
        expect(page).to have_no_content product_name
      end
    end
    
    context 'when the price is missing' do    
      let(:product_price) { 1 }

      before do
        fill_in 'product_price', with: product_price
        click_button 'Create Product'
      end

      it 'displays an error' do
        expect(page).to have_content 'Name can\'t be blank'
      end

      it 'is not adding new product' do
        visit '/'
        expect(page).to have_no_content product_price
      end
    end
  end
end
