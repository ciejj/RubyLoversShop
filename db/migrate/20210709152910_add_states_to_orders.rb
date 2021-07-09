class AddStatesToOrders < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE order_state AS ENUM ('new', 'failed', 'completed');
    SQL
    add_column :orders, :state, :order_state
  end

  def down
    remove_column :orders, :state
    execute <<-SQL
      DROP TYPE order_state;
    SQL
  end
end
