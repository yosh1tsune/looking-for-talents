FactoryBot.define do
  factory :headhunter do
    name { 'José' }
    surname { 'Silva' }
    email { Faker::Internet.email }
    password { 'head1234' }
    confirmed_at { Time.zone.now }
  end
end
