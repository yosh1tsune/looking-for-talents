class Profile < ApplicationRecord
  has_one_attached :avatar
  validates :name, :birth_date, :document, :professional_resume, :scholarity,
            :candidate_id, presence: true
  belongs_to :candidate
  has_many :comments, dependent: :destroy
  has_many :addresses, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :addresses
end
