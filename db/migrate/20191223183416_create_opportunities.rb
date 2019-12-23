class CreateOpportunities < ActiveRecord::Migration[6.0]
  def change
    create_table :opportunities do |t|
      t.string :title
      t.text :work_description
      t.text :required_abilities
      t.string :salary
      t.string :grade
      t.string :address
      t.date :submit_end_date

      t.timestamps
    end
  end
end
