class Message < ApplicationRecord
  has_one_attached :file
  belongs_to :chat
  belongs_to :from, polymorphic: true
  belongs_to :to, polymorphic: true

  validates :text, presence: true
end
