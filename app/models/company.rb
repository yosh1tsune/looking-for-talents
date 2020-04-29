class Company < ApplicationRecord
  validates :name, :description, :document, :phone, :email, presence: true
  belongs_to :headhunter
end
