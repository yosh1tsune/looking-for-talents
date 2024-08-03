FactoryBot.define do
  factory :profile do
    candidate
    name { Faker::Name.name }
    birth_date { Faker::Date.birthday(min_age: 16, max_age: 70) }
    document { Faker::IDNumber.brazilian_citizen_number }
    scholarity { 'Superior Incompleto' }
    professional_resume { 'Estágio em Desenvolvimento Web' }
    avatar do
      Rack::Test::UploadedFile.new('spec/support/user.jpg',
                                   'image/jpg')
    end
  end
end
