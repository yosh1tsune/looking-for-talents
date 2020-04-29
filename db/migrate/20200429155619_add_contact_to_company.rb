class AddContactToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :email, :string
    add_column :companies, :phone, :string
  end
end
