FactoryBot.define do
  factory :experience do
    profile
    resume { 'Desenvolvimendo de Aplicações Web' }
    start_date { '20/08/2019' }
    end_date { '20/08/2020' }
    currently_working { false }
    company { 'Ruby Aplicações' }
    role { 'Desenvolvedor Web' }
  end
end
