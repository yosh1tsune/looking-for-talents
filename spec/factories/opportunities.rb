FactoryBot.define do
  factory :opportunity do
    headhunter
    title { 'Desenvolvedor Rails' }
    work_description { 'Desenvolver aplicações web' }
    required_abilities { 'Ruby on Rails' }
    salary { 2800 }
    grade { 'Júnior' }
    submit_end_date { 7.days.from_now }
    company
  end
end
