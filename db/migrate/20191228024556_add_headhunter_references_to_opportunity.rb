class AddHeadhunterReferencesToOpportunity < ActiveRecord::Migration[6.0]
  def change
    add_reference :opportunities, :headhunter, foreign_key: true
  end
end
