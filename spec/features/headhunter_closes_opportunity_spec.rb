require 'rails_helper'

feature 'headhunter closes opportunity' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')                                
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas'
        click_on opportunity.title
        click_on 'Encerrar inscrições'

        expect(page).to have_content(opportunity.work_description)
        expect(page).to have_content("#{I18n.t('work_description')}: #{opportunity.work_description}")
        expect(page).to have_content("#{I18n.t('required_abilities')}: #{opportunity.required_abilities}")
        expect(page).to have_content("#{I18n.t('salary')}: #{opportunity.salary}")
        expect(page).to have_content("#{I18n.t('submit_end_date')}: #{I18n.l(opportunity.submit_end_date)}")
        expect(page).to have_content("#{I18n.t('grade')}: #{opportunity.grade}")
        expect(page).to have_content("#{I18n.t('address')}: #{opportunity.address}")
        expect(page).not_to have_link('Encerrar inscrições')
    end

    scenario 'and must see only his' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')                        
        another_headhunter = Headhunter.create!(email: 'another_headhunter@email.com', password: 'head1234')                        
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)                                
        another_opportunity = Opportunity.create!(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: another_headhunter)

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas'
        
        expect(page).to have_content(opportunity.title)
        expect(page).not_to have_content(another_opportunity.title)
    end
end