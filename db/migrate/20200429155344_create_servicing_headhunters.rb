class CreateServicingHeadhunters < ActiveRecord::Migration[6.0]
  def change
    create_table :servicing_headhunters do |t|
      t.references :headhunter, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
