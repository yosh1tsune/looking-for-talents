require 'rails_helper'

feature 'headhunter submit comment into candidate profile' do
    scenario 'succesfully' do
        candidate = create(:candidate, email: 'candidate@email.com')
        headhunter = create(:headhunter, email: 'headhunter@email.com')
        profile = create(:profile, name: 'Bruno Silva', candidate: candidate)

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
        candidate = create(:candidate, email: 'candidate@email.com')
        headhunter = create(:headhunter, email: 'headhunter@email.com')
        profile = create(:profile, name: 'Bruno Silva', candidate: candidate)

        login_as(headhunter, scope: :headhunter)
        visit root_path
        click_on 'Perfil'
        click_on profile.name
        fill_in 'Comentário', with: ''
        click_on 'Comentar'

        expect(page).to have_content("Comments não é válido")
    end
end