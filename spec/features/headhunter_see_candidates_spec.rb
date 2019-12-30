require 'rails_helper'

feature 'headhunter see candidates' do
    scenario 'successfully from profiles#index' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        another_candidate = Candidate.create!(email: 'another_candidate@email.com', password: 'head1234')
        another_profile = Profile.create!(name: 'Julio Dias', birth_date: '13/04/1999', document: '996.490.558-00', scholarity: 'Ensino médio completo', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: another_candidate)

        third_candidate = Candidate.create!(email: 'third_candidate@email.com', password: 'head1234')
        third_profile = Profile.create!(name: 'Luis Pereira', birth_date: '05/12/1989', document: '996.490.558-00', scholarity: 'Superior Completo', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: third_candidate)

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Perfil'

        expect(page).to have_content(profile.name)
        expect(page).to have_content(profile.professional_resume)
        expect(page).to have_content(another_profile.name)
        expect(page).to have_content(another_profile.professional_resume)
        expect(page).to have_content(third_profile.name)
        expect(page).to have_content(third_profile.professional_resume)
    end

    scenario "unsuccessfully on profiles#index if there's no profiles registered" do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Perfil'

        expect(page).to have_content('Ainda não há perfis cadastrados')
    end

    scenario 'successfully from opportunity#show when candidates are registered' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        another_candidate = Candidate.create!(email: 'another_candidate@email.com', password: 'head1234')
        another_profile = Profile.create!(name: 'Julio Dias', birth_date: '13/04/1999', document: '996.490.558-00', scholarity: 'Ensino médio completo', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: another_candidate)

        third_candidate = Candidate.create!(email: 'third_candidate@email.com', password: 'head1234')
        third_profile = Profile.create!(name: 'Luis Pereira', birth_date: '05/12/1989', document: '996.490.558-00', scholarity: 'Superior Completo', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: third_candidate)
                                
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)

        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web')
        another_registration = Subscription.create!(opportunity: opportunity, candidate: another_candidate, registration_resume: '3 anos de experiencia como analista de suporte')
        third_registration = Subscription.create!(opportunity: opportunity, candidate: third_candidate, registration_resume: 'Projetos acadêmicos')

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Vagas'
        click_on 'Desenvolvedor Júnior Ruby on Rails'

        expect(page).to have_content(profile.name)
        expect(page).to have_content(registration.registration_resume)
        expect(page).to have_content(another_profile.name)
        expect(page).to have_content(another_registration.registration_resume)
        expect(page).to have_content(third_profile.name)
        expect(page).to have_content(third_registration.registration_resume)
    end

    scenario 'and visualize their profiles' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        another_candidate = Candidate.create!(email: 'another_candidate@email.com', password: 'head1234')
        another_profile = Profile.create!(name: 'Luis Pereira', birth_date: '05/12/1989', document: '996.490.558-00', scholarity: 'Superior Completo', 
                                professional_resume: 'Analista de suporte', address: 'Alameda Santos, 1293', candidate: another_candidate)
                                
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)

        Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web')
        Subscription.create!(opportunity: opportunity, candidate: another_candidate, registration_resume: '3 anos como analista de suporte')

        login_as(headhunter, scope: :headhunter)
        visit opportunities_path
        click_on 'Desenvolvedor Júnior Ruby on Rails'
        click_on another_profile.name

        expect(page).to have_content(another_profile.name)
        expect(page).to have_content("#{I18n.t('birth_date')}: #{I18n.l(another_profile.birth_date)}")
        expect(page).to have_content("#{I18n.t('document')}: #{another_profile.document}")
        expect(page).to have_content("#{I18n.t('scholarity')}: #{another_profile.scholarity}")
        expect(page).to have_content("#{I18n.t('professional_resume')}: #{another_profile.professional_resume}")
        expect(page).to have_content("#{I18n.t('address')}: #{another_profile.address}")
    end
end