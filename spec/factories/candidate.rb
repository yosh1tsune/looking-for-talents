FactoryBot.define do
    sequence :email do |n|
        "candidate#{n}@email.com"
    end
    
    factory :candidate do
        email { generate :email }
        password { 'cand1234' }
    end
end