class AddStatusToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_column :opportunities, :status, :integer, default: 0, null: false
  end
end
