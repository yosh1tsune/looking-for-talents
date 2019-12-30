require 'rails_helper'

describe Opportunity do
    describe '.date_validator' do
        it 'successfully' do
            headhunter = Headhunter.create(email: 'headhunter@email.com', password: 'head1234')
            opportunity = Opportunity.create(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                                required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                                grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
            
            opportunity.valid?

            expect(opportunity.errors).to be_empty
        end

        it 'unsuccessfully if minor than 7 days' do
            headhunter = Headhunter.create(email: 'headhunter@email.com', password: 'head1234')
            opportunity = Opportunity.create(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                                required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                                grade: 'Especialista', submit_end_date: 6.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
            
            opportunity.valid?

            expect(opportunity.errors.full_messages).to eq(["#{I18n.t('submit_end_date')} deve ser ao menos daqui a 7 dias"])
        end

        it 'unsuccessfully if submit_end_date blank' do
            headhunter = Headhunter.create(email: 'headhunter@email.com', password: 'head1234')
            opportunity = Opportunity.create(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                                required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                                grade: 'Especialista', address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
            
            opportunity.valid?

            expect(opportunity.errors.full_messages).to eq(["#{I18n.t('submit_end_date')} não pode ficar em branco"])
        end
    end
end
