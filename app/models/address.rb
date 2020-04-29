class Address < ApplicationRecord
  validates :street, :neighborhood, :state, :country, :zipcode presence: true
  belogns_to :company, dependent: :destroy
end
