# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cart - Checkout', type: :system do
  before { create(:product) }

  context 'when logged in as user' do
    before do
      login_as(create(:user), scope: :user)
    end

    context 'with product in the cart' do
      before do
        visit '/'
        click_button 'Add to Cart'
        click_link('Cart', exact: true)
        click_link('Checkout', exact: true)
      end

      it 'is placing a new order' do
        expect(page).to have_content('Order has been placed')
      end

      it 'redirects to billing address form' do
        expect(page).to have_current_path(new_orders_billing_address_path)
      end

      describe 'filling billing address form' do
        context 'with valid address attributes' do
          let(:address_params) { attributes_for(:address) }

          before do
            fill_in 'address_street_name1', with: address_params[:street_name1]
            fill_in 'address_city', with: address_params[:city]
            fill_in 'address_country', with: address_params[:country]
            fill_in 'address_state', with: address_params[:state]
            fill_in 'address_zip', with: address_params[:zip]
            fill_in 'address_phone', with: address_params[:phone]
            click_button 'Save Billing Address'
          end

          it 'is successful' do
            expect(page).to have_content 'Billing Address has been created'
          end

          it 'redirects to home page' do
            expect(page).to have_current_path('/')
          end
        end

        context 'with invalid address attributes' do
          before do
            click_button 'Save Billing Address'
          end

          it 'displays form validation errors' do
            expect(page).to have_content 'There were errors that prevented this form from being saved:'
          end

          it 'stays on the same page' do
            expect(page).to have_current_path(orders_billing_address_path)
          end
        end
      end
    end
  end
end
