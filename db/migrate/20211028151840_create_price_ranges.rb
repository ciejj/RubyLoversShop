class CreatePriceRanges < ActiveRecord::Migration[6.1]
  def change
    create_table :price_ranges do |t|
      t.float :min
      t.float :max
    end
  end
end
