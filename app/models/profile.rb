class Profile < ApplicationRecord
  belongs_to :candidate
  belongs_to :address
end
