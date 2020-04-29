class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :country
      t.string :zipcode

      t.timestamps
    end
  end
end
