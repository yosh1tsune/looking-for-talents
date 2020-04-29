class RemoveAdressFromOpportunity < ActiveRecord::Migration[6.0]
  def change

    remove_column :opportunities, :address, :string
  end
end
