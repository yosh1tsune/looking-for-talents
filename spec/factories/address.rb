FactoryBot.define do
  factory :address do
    street { 'Avenida Paulista, 1000' }
    city { 'São Paulo' }
    country { 'Brasil' }
    zipcode { '00000-000' }
    neighborhood { 'Bela Vista' }
    state { 'SP' }
    addressable { profile }
  end
end
