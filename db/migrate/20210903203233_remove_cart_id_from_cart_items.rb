class RemoveCartIdFromCartItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :cart_items, :cart_id, :bigint
  end
end
