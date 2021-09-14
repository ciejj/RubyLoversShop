class AddQuantityToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_items, :quantity, :integer, null: false, default: 1
  end
end
