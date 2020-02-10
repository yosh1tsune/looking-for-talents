FactoryBot.define do
  factory :candidate do
    email { Faker::Internet.email }
    password { 'cand1234' }
  end
end
