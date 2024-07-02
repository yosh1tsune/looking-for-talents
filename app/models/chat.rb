class Chat < ApplicationRecord
  belongs_to :headhunter
  belongs_to :candidate
  has_many :messages, dependent: :destroy
end
