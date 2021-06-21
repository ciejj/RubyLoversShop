# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Editing Product', type: :system do
  context 'when logged in as admin' do
    let!(:administrator) { create(:administrator) }
    let!(:product) { create(:product) }

    before do
      login_as(administrator, scope: :administrator)
      visit admin_products_path
    end

    context 'when editing product with valid attributes' do
      let(:new_name) { 'new_product_name' }

      before do
        find("#edit-product-#{product.id}-button").click
        fill_in 'product_name', with: new_name
        fill_in 'product_price', with: '189'
        click_button 'Save Product'
      end

      it 'edits product successfully' do
        expect(page).to have_content 'Product edited successfully'
      end

      it 'shows edited product on product_index' do
        expect(page).to have_content new_name
      end

      it 'shows edited product on home page' do
        visit '/'
        expect(page).to have_content new_name
      end
    end

    context 'when editing product without price' do
      let(:product_name) { 'product_with_no_price' }

      before do
        find("#edit-product-#{product.id}-button").click
        fill_in 'product_name', with: product_name
        fill_in 'product_price', with: ''
        click_button 'Save Product'
      end

      it 'displays missing price error' do
        expect(page).to have_content 'Price can\'t be blank'
      end

      it 'does not change the name of the product' do
        visit '/'
        expect(page).to have_no_content product_name
      end
    end

    context 'when editing product without name' do
      let(:product_price) { 183_420_592 }

      before do
        find("#edit-product-#{product.id}-button").click
        fill_in 'product_name', with: ''
        fill_in 'product_price', with: product_price
        click_button 'Save Product'
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
