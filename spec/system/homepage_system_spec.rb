require "rails_helper"

RSpec.describe "Home Page", type: :system do

  before(:all) do
      product1 = create(:product, name: 'product_1')
      product2 = create(:product, name: 'product_2')
  end

  it "displays all available Products" do
    visit "/"

    expect(page).to have_text("product_1")
    expect(page).to have_text("product_2")
  end
end