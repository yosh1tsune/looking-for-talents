class AddCompanyToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :company, :string
  end
end
