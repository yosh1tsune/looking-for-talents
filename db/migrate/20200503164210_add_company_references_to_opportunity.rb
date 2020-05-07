class AddCompanyReferencesToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_reference :opportunities, :company, null: false, default: 0, foreign_key: true
  end
end
