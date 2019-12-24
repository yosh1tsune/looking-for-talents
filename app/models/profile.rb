class Profile < ApplicationRecord
  validates :name, :birth_date, :document, :professional_resume, :scholarity, :address, :candidate_id, presence: true
  belongs_to :candidate
end
