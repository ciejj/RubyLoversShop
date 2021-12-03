class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true, null: false
      t.string :street_name1
      t.string :street_name2
      t.string :city
      t.string :country
      t.string :state
      t.string :zip
      t.string :phone

      t.timestamps
    end
  end
end
