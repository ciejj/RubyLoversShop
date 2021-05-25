require "rails_helper"

RSpec.describe "Home Page", type: :system do

  before(:each) do
      product1 = create(:product, name: 'product_1')
      product2 = create(:product, name: 'product_2')
  end

  it "displays all available Products" do
    visit "/"

    assert_selector "h4.card-title", text: "product_1"
    assert_selector "h4.card-title", text: "product_2"
    assert_selector "h4.card-title", count: 2
  end
end

