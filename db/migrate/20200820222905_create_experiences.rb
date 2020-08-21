class CreateExperiences < ActiveRecord::Migration[6.0]
  def change
    create_table :experiences do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :resume
      t.date :start_date
      t.date :end_date
      t.boolean :currently_working, default: false
      t.string :company
      t.string :role

      t.timestamps
    end
  end
end
