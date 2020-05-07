class RemoveCompanyFromOpportunities < ActiveRecord::Migration[6.0]
  def change
    remove_column :opportunities, :company, :string
  end
end
