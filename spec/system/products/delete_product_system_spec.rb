# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Deleting Product', type: :system do
  context 'when logged in as admin' do
    let!(:administrator) { create(:administrator) }
    let!(:product) { create(:product) }

    before do
      login_as(administrator, scope: :administrator)
      visit admin_products_path
    end

    context 'when deleting product' do
      before do
        find("#delete-product-#{product.id}-button").click
      end

      it 'deletes product successfully' do
        expect(page).to have_content 'Product deleted successfully'
      end

      it 'removes product from product index' do
        expect(page).not_to have_content product.name
      end
    end
  end
end
