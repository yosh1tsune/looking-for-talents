class Subscription < ApplicationRecord
  validates :candidate_id, :opportunity_id, :registration_resume, presence: true
  belongs_to :candidate
  belongs_to :opportunity
  has_one :proposal
  has_one :profile, through: :candidate

  enum status: { in_progress: 0, approved: 1, refused: 2 }
end
