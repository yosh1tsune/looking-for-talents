require 'rails_helper'

feature 'candidate register to opportunity' do
    scenario 'successfully' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        Opportunity.create!(title: 'Engenheiro de Software', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista')

        login_as(candidate)
        visit root_path
        click_on 'Vagas'
        click_on 'Engenheiro de Software'
        click_on I18n.t('register')

        expect(page).to have_content('Inscrição realizada com sucesso!')
        expect(page).not_to have_link(I18n.t('register'))
        expect(page).to have_content(I18n.t('already_registered'))
    end

    scenario 'and must be loged' do
        Opportunity.create!(title: 'Engenheiro de Software', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista')

        visit opportunities_path
        click_on 'Engenheiro de Software'
        
        expect(page).not_to have_link(I18n.t('register'))
    end

    scenario 'and must be not already registered' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        opportunity = Opportunity.create!(title: 'Engenheiro de Software', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista')
        Registration.create!(opportunity: opportunity, candidate: candidate)

        login_as(candidate)
        visit opportunities_path
        click_on 'Engenheiro de Software'
        
        expect(page).not_to have_link(I18n.t('register'))
        expect(page).to have_content(I18n.t('already_registered'))
    end
end