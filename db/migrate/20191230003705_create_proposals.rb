class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.date :start_date
      t.decimal :salary
      t.text :benefits
      t.text :role
      t.text :expectations
      t.text :bonuses
      t.references :subscription, null: false, foreign_key: true
      t.references :opportunity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
