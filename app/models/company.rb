class Company < ApplicationRecord
  validates :name, :description, :document, :phone, :email, presence: true
  belongs_to :headhunter
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :servicing_headhunters, dependent: :destroy
  has_many :headhunters, through: :servicing_headhunters
end
