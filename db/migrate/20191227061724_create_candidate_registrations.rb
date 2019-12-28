class CreateCandidateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :candidate_registrations do |t|
      t.references :candidate, null: false, foreign_key: true
      t.references :opportunity, null: false, foreign_key: true
      t.text :registration_resume
      t.boolean :highlighted
      t.integer :status
      t.text :feedback

      t.timestamps
    end
  end
end
