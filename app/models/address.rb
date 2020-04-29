class Address < ApplicationRecord
  validates :street, :neighborhood, :city, :state, :country, :zipcode,
            presence: true
  belongs_to :addressable, polymorphic: true
end
