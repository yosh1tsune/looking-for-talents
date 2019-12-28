require 'rails_helper'

feature 'candidate apply to opportunity' do
    scenario 'successfully' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        Opportunity.create!(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Vagas'
        click_on 'Engenheiro de Software'
        fill_in I18n.t('registration_resume'), with: '2 anos de experiência com gerenciamento de BD'
        click_on I18n.t('register')

        expect(page).to have_content('Inscrição realizada com sucesso!')
        expect(page).not_to have_link(I18n.t('register'))
        expect(page).to have_content(I18n.t('already_registered'))
    end

    scenario 'and must be loged' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        Opportunity.create!(title: 'Engenheiro de Software', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        visit opportunities_path
        click_on 'Engenheiro de Software'
        
        expect(page).not_to have_link(I18n.t('register'))
    end

    scenario 'and must be not already registered' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        opportunity = Opportunity.create!(title: 'Engenheiro de Software', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
        CandidateRegistration.create!(opportunity: opportunity, candidate: candidate, registration_resume: '2 anos de experiência com gerenciamento de BD')

        login_as(candidate, scope: :candidate)
        visit opportunities_path
        click_on 'Engenheiro de Software'
        
        expect(page).not_to have_link(I18n.t('register'))
        expect(page).to have_content(I18n.t('already_registered'))
    end
end