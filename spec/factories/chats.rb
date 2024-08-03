FactoryBot.define do
  factory :chat do
    headhunter
    candidate
    websocket_uuid { SecureRandom.uuid }
  end
end
