FactoryBot.define do
  factory :message do
    chat
    association :from, factory: :headhunter
    association :to, factory: :candidate
    text { 'Hello!' }
  end
end
