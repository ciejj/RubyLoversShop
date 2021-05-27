require 'rails_helper'

RSpec.describe 'Home Page', type: :system do

    let!(:category_1) { create(:category, name: 'category_1') }
    let!(:category_2) { create(:category, name: 'category_2') }
    let!(:product_1)  { create(:product, name: 'product_1', category: category_1) }
    let!(:product_2)  { create(:product, name: 'product_2', category: category_2) }
  
  it 'displays all available Products' do
    visit '/'

    assert_selector 'h4.card-title', text: 'product_1'
    assert_selector 'h4.card-title', text: 'product_2'
    assert_selector 'h4.card-title', count: 2
  end

  it 'displays only Products from chosen category' do
    visit '/'
    click_on 'category_1'
    
    assert_selector 'h4.card-title', text: 'product_1'
    assert_selector 'h4.card-title', count: 1
  end
end
