class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.date :birth_date
      t.string :document
      t.string :scholarity
      t.text :professional_resume
      t.boolean :highlighted, default: false
      t.string :address
      t.references :candidate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
