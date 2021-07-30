class AddStateToPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :state, :string, default: 'pending'
  end
end
