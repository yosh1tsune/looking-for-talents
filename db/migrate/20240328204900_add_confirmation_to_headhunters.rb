class AddConfirmationToHeadhunters < ActiveRecord::Migration[7.1]
  def change
    add_column :headhunters, :confirmation_token, :string
    add_column :headhunters, :confirmed_at, :datetime
    add_column :headhunters, :confirmation_sent_at, :datetime
    add_column :headhunters, :unconfirmed_email, :string
  end
end
