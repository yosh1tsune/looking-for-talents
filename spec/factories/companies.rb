FactoryBot.define do
  factory :company do
    name { 'RR System' }
    document { '66.864.712/0001-67' }
    description { 'Soluções para desenvolvimento de apps em Ruby' }
    phone { '(11) 9999-9999' }
    email { 'rrsystem@lookingfortalents.com' }
    headhunter
  end
end
