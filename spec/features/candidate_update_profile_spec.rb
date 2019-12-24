require 'rails_helper'

feature 'candidate updates profile' do
    scenario "candidate still don't have profile" do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')

        login_as(candidate)
        visit root_path
        click_on 'Perfil'

        expect(page).to have_content('Atualize seu perfil')
        expect(current_path).to eq(new_profile_path)
    end

    scenario 'and create if not' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')

        login_as(candidate)
        visit profile_path(candidate)

        fill_in I18n.t('name'), with: 'Bruno Silva'
        fill_in I18n.t('birth_date'), with: '22/04/1996'
        fill_in I18n.t('document'), with: '996.490.558-00'
        fill_in I18n.t('scholarity'), with: 'Superior Incompleto'
        fill_in I18n.t('professional_resume'), with: 'Desenvolvimento web com Dart 2'
        fill_in I18n.t('address'), with: 'Alameda Santos, 1293'
        click_on 'Enviar'

        expect(page).to have_content('Perfil atualizado com sucesso')
        expect(page).to have_content('Bruno Silva')        
        expect(page).to have_content("#{I18n.t('birth_date')}: 22/04/1996")        
        expect(page).to have_content("#{I18n.t('document')}: 996.490.558-00")
        expect(page).to have_content("#{I18n.t('scholarity')}: Superior Incompleto")   
        expect(page).to have_content("#{I18n.t('professional_resume')}: Desenvolvimento web com Dart 2")   
        expect(page).to have_content("#{I18n.t('address')}: Alameda Santos, 1293")   
    end

    scenario 'or edit if already have' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
        
        login_as(candidate)
        visit profile_path(candidate)
        click_on 'Editar perfil'
        fill_in I18n.t('professional_resume'), with: 'Desenvolvimento web com Dart 2, Ruby on Rails, TDD'
        fill_in I18n.t('address'), with: 'Avenida Paulista, 1000'
        click_on 'Enviar'

        expect(page).to have_content('Perfil atualizado com sucesso')
        expect(page).to have_content('Bruno Silva')
        expect(page).to have_content("#{I18n.t('birth_date')}: 22/04/1996")      
        expect(page).to have_content("#{I18n.t('document')}: 996.490.558-00")
        expect(page).to have_content("#{I18n.t('scholarity')}: Superior Incompleto")
        expect(page).to have_content("#{I18n.t('professional_resume')}: Desenvolvimento web com Dart 2, Ruby on Rails, TDD")
        expect(page).to have_content("#{I18n.t('address')}: Avenida Paulista, 1000")
    end

    scenario 'and must fill all fields' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
        
        login_as(candidate)
        visit profile_path(candidate)
        click_on 'Editar perfil'

        fill_in I18n.t('name'), with: 'Bruno Silva'
        fill_in I18n.t('birth_date'), with: '22/04/1996'
        fill_in I18n.t('document'), with: '996.490.558-00'
        fill_in I18n.t('scholarity'), with: 'Superior Incompleto'
        fill_in I18n.t('professional_resume'), with: 'Desenvolvimento web com Dart 2, Ruby on Rails, TDD'
        fill_in I18n.t('address'), with: ''
        click_on 'Enviar'

        expect(current_path).to eq profile_path(candidate)
        expect(page).to have_content("#{I18n.t('address')} não pode ficar em branco")
    end
end