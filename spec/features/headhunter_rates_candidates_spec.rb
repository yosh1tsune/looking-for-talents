require 'rails_helper'

feature 'headhunter rates candidates' do
    scenario 'successfully approve' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)

        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web')

        login_as(headhunter, scope: :headhunter)
        visit opportunities_path
        click_on 'Desenvolvedor Júnior Ruby on Rails'
        click_on "#{registration.id}"
        fill_in I18n.t('feedback'), with: 'Sua experiência condiz com o requerido'
        select :approved, from: I18n.t('status')
        click_on 'Avaliar'
        
        expect(page).to have_content('Inscrição atualizada com sucesso')
        expect(page).to have_content("#{I18n.t('status')}: #{I18n.t('approved')}")
        expect(page).to have_content("#{I18n.t('feedback')}: #{registration.feedback}")
    end

    scenario 'successfully refuse' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)

        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web')

        login_as(headhunter, scope: :headhunter)
        visit opportunities_path
        click_on 'Desenvolvedor Júnior Ruby on Rails'
        click_on "#{registration.id}"
        fill_in I18n.t('feedback'), with: 'Precisamos de alguém com experiência em Rails'
        select :refuse, from: I18n.t('status')
        click_on 'Avaliar'
        
        expect(page).to have_content('Inscrição atualizada com sucesso')
        expect(page).to have_content("#{I18n.t('status')}: #{I18n.t('refused')}")
        expect(page).to have_content("#{I18n.t('feedback')}: #{registration.feedback}")
    end
end