FactoryBot.define do
    factory :opportunity do
        headhunter
        title { 'Desenvolvedor Rails' }
        work_description { 'Desenvolver aplicações web' }
        required_abilities { 'Ruby on Rails' }
        salary { 2800 }
        grade { 'Júnior' }
        address { 'Alameda Santos, 1239' }
        submit_end_date { '01/02/2030' }
        company { 'RR Systems' }
    end
end