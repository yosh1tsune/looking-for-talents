class AddNameToHeadhunter < ActiveRecord::Migration[6.0]
  def change
    add_column :headhunters, :name, :string
    add_column :headhunters, :surname, :string
  end
end
