class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :chat, null: false, foreign_key: true
      t.references :from, polymorphic: true, null: false
      t.references :to, polymorphic: true, null: false
      t.string :text

      t.timestamps
    end
  end
end
