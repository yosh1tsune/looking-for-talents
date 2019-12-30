require 'rails_helper'

feature 'candidate see his opportunities and feedbacks' do
    scenario 'successfully while in progress' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)
        another_opportunity = Opportunity.create!(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                                required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                                grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web')
        another_registration = Subscription.create!(opportunity: another_opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web')
        
        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Minhas vagas'

        expect(page).to have_content(registration.opportunity.title)
        expect(page).to have_content('Status: Em andamento')

        expect(page).to have_content(another_registration.opportunity.title)
        expect(page).to have_content('Status: Em andamento')
    end

    scenario 'successfully if refused' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)

        opportunity = Opportunity.create!(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                                required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                                grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web',
                                                    status: 2, feedback: 'Pouca experiência')
        
        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Minhas vagas'

        expect(page).to have_content(registration.opportunity.title)
        expect(page).to have_content('Status: Recusada')
        expect(page).to have_content("#{I18n.t('feedback')}: #{registration.feedback}")
    end

    scenario 'successfully if approved' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)

        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                                    required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                                    submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)

        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web',
                                                    status: 1, feedback: 'Parabéns, você foi aprovado! Aguarde o contato do recrutador')
        
        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Minhas vagas'

        expect(page).to have_content(registration.opportunity.title)
        expect(page).to have_content('Status: Aprovado')
        expect(page).to have_content("#{I18n.t('feedback')}: #{registration.feedback}")
    end

    scenario "and unsuccessfully if there's no registrations" do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
        
        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Minhas vagas'

        expect(page).to have_content('Você ainda não se inscreveu em nenhuma vaga')
    end
end