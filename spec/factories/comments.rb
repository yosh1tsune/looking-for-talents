FactoryBot.define do
    factory :comment do
        headhunter
        profile
        comment { 'Boas experiências' }
    end
end