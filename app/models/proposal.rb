class Proposal < ApplicationRecord
  belongs_to :subscription
  belongs_to :opportunity
  has_one :headhunter, through: :opportunity
  has_one :candidate, through: :subscription
end
