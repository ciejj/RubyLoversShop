require 'rails_helper'

RSpec.describe 'Home Page', type: :system do

    let!(:category_1) { create(:category, name: 'category_1') }
    let!(:category_2) { create(:category, name: 'category_2') }
    let!(:brand_1) { create(:brand, name: 'brand_1') }
    let!(:brand_2) { create(:brand, name: 'brand_2') }

    let!(:product_1_1)  { create(:product, name: 'product_1_1', category: category_1, brand: brand_1) }
    let!(:product_1_2)  { create(:product, name: 'product_1_2', category: category_1, brand: brand_2) }
    let!(:product_2_1)  { create(:product, name: 'product_2_1', category: category_2, brand: brand_1) }
    let!(:product_2_2)  { create(:product, name: 'product_2_2', category: category_2, brand: brand_2) }
  

  context 'when no filters are applied' do 
    it 'displays all available Products' do
      visit '/'
  
      assert_selector 'h4.card-title', text: 'product_1_1'
      assert_selector 'h4.card-title', text: 'product_1_2'
      assert_selector 'h4.card-title', text: 'product_2_1'
      assert_selector 'h4.card-title', text: 'product_2_2'
      assert_selector 'h4.card-title', count: 4
    end
  end

  context 'when only Category filter is applied' do

    it 'displays only Products from chosen Category' do
      visit '/'
      click_on 'category_1'
      
      assert_selector 'h4.card-title', text: 'product_1_1'
      assert_selector 'h4.card-title', text: 'product_1_2'
      assert_selector 'h4.card-title', count: 2
    end
  end

  context 'when only Brand filter is applied' do
    it 'displays only Products from chosen Brand' do
      visit '/'
      click_on 'brand_1'
      
      assert_selector 'h4.card-title', text: 'product_1_1'
      assert_selector 'h4.card-title', text: 'product_2_1'
      assert_selector 'h4.card-title', count: 2
    end
  end

  context 'when only Brand and Category filters are applied' do
    it 'displays only Products from chosen Brand' do
      visit '/'
      click_on 'brand_1'
      click_on 'category_1'
      
      assert_selector 'h4.card-title', text: 'product_1_1'
      assert_selector 'h4.card-title', count: 1
    end
  end





end
