FactoryBot.define do
  factory :profile do
    candidate
    name { 'Bruno Silva' }
    birth_date { '22/04/1996' }
    document { '441.723.698-47' }
    scholarity { 'Superior Incompleto' }
    professional_resume { 'Estágio em Desenvolvimento Web' }
    avatar do
      Rack::Test::UploadedFile.new('spec/support/user.jpg',
                                   'image/jpg')
    end
  end
end
