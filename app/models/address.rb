class Address < ApplicationRecord
  has_many :opportunities, dependent: :destroy
end
