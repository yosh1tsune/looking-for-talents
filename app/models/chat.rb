class Chat < ApplicationRecord
  belongs_to :headhunter
  belongs_to :candidate
  has_many :messages, dependent: :destroy

  validates :websocket_uuid, presence: true
end
