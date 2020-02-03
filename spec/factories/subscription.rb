FactoryBot.define do
    factory :subscription do
        candidate
        opportunity
        registration_resume { 'Estágio em desenvolvimento web e graduando em ADS' }
    end
end