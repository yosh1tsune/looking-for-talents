class Comment < ApplicationRecord
  validates :comment, presence: true
  belongs_to :profile
  belongs_to :headhunter
end
