FactoryBot.define do
  factory :proposal do
    start_date { 30.days.from_now }
    salary { 3000 }
    benefits { 'Convênio médico, VT, VR' }
    role { 'Desenvolvedor Ruby on Rails' }
    expectations { 'Integrar o time de testes' }
    bonuses { 'PLR' }
    opportunity
    subscription
  end
end
