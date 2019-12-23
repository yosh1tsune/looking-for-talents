class AddColumnProfileIdToCandidate < ActiveRecord::Migration[6.0]
  def change
    add_reference :candidates, :profile, null: true, foreign_key: true
  end
end
