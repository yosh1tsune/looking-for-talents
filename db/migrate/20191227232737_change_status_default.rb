class ChangeStatusDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :candidate_registrations, :status, from: nil, to: 0
  end
end
