FactoryBot.define do
  factory :headhunter do
    email { Faker::Internet.email }
    password { 'head1234' }
  end
end
