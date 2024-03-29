FactoryBot.define do
  factory :candidate do
    email { Faker::Internet.email }
    password { 'cand1234' }
    confirmed_at { Time.now }
  end
end
