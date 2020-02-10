class Profile < ApplicationRecord
  has_one_attached :avatar
  validates :name, :birth_date, :document, :professional_resume, :scholarity,
            :address, :candidate_id, presence: true
  belongs_to :candidate
  has_many :comments
end
