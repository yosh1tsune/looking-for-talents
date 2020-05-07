FactoryBot.define do
  factory :headhunter do
    name { 'José' }
    surname { 'Silva' }
    email { Faker::Internet.email }
    password { 'head1234' }
  end
end
