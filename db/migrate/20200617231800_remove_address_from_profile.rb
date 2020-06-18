class RemoveAddressFromProfile < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :address, :string
  end
end
