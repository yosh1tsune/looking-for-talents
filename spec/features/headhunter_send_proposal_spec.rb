require 'rails_helper'

feature 'headhunter send proposal' do
    scenario 'successfully approve' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

        login_as(headhunter, scope: :headhunter)
        visit opportunities_path
        click_on 'Desenvolvedor Júnior Ruby on Rails'
        click_on "#{registration.id}"
        fill_in I18n.t('start_date'), with: '01/02/2030'
        fill_in I18n.t('salary'), with: 2800
        fill_in I18n.t('role'), with: 'Desenvolvedor Júnior'
        fill_in I18n.t('benefits'), with: 'Vale Transporte, Vale Refeição, Convênio Médico'
        fill_in I18n.t('expectations'), with: 'Colaborar com as rotinas de testes do time de desenvolvimento'
        fill_in I18n.t('bonuses'), with: 'Participação de lucros'
        click_on 'Enviar proposta'

        expect(page).to have_content('Proposta enviada!')
        expect(page).to have_content("Vaga: #{opportunity.title}")
        expect(page).to have_content("#{I18n.t('start_date')}: 01/02/2030")
        expect(page).to have_content("#{I18n.t('salary')}: 2800")
        expect(page).to have_content("#{I18n.t('role')}: Desenvolvedor Júnior")
        expect(page).to have_content("#{I18n.t('benefits')}: Vale Transporte, Vale Refeição, Convênio Médico")
        expect(page).to have_content("#{I18n.t('expectations')}: Colaborar com as rotinas de testes do time de desenvolvimento")
        expect(page).to have_content("#{I18n.t('bonuses')}: Participação de lucros")
    end

    scenario 'and must fill all fields' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

        login_as(headhunter, scope: :headhunter)
        visit opportunities_path
        click_on 'Desenvolvedor Júnior Ruby on Rails'
        click_on "#{registration.id}"
        fill_in I18n.t('start_date'), with: '01/02/2020'
        fill_in I18n.t('salary'), with: 2800
        fill_in I18n.t('role'), with: 'Desenvolvedor Júnior'
        fill_in I18n.t('benefits'), with: 'Vale Transporte, Vale Refeição, Convênio Médico'
        fill_in I18n.t('expectations'), with: 'Colaborar com as rotinas de testes do time de desenvolvimento'
        fill_in I18n.t('bonuses'), with: ''
        click_on 'Enviar proposta'

        expect(page).to have_content('Proposta não enviada, preencha todos os campos!')
    end
end