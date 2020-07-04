class Company < ApplicationRecord
  has_one_attached :logo
  validates :name, :description, :document, :phone, :email, :logo,
            presence: true
  belongs_to :headhunter
  has_many :addresses, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :addresses
  has_many :servicing_headhunters, dependent: :destroy
  has_many :headhunters, through: :servicing_headhunters
end
