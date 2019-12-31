require 'rails_helper'

feature 'headhunter submit comment into candidate profile' do
    scenario 'succesfully' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Perfil'
        click_on profile.name
        fill_in I18n.t('comment'), with: 'Gostei do seu resumo profissional'
        click_on 'Comentar'

        expect(page).to have_content("Comentário enviado!")
        expect(page).to have_content("Autor: #{headhunter.email}")
        expect(page).to have_content('Gostei do seu resumo profissional')
    end

    scenario 'and must send a not blank comment' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Perfil'
        click_on profile.name
        fill_in 'Comentário', with: ''
        click_on 'Comentar'

        expect(page).to have_content("Comments não é válido")
    end
end