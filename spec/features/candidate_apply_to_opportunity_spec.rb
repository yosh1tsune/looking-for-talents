require 'rails_helper'

feature 'candidate apply to opportunity' do
    scenario 'successfully' do
        candidate = create(:candidate)
        opportunity = create(:opportunity, title: 'Desenvolvedor Rails')

        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Vagas'
        click_on opportunity.title
        fill_in I18n.t('registration_resume'), with: '2 anos de experiência com gerenciamento de BD'
        click_on I18n.t('register')

        expect(page).to have_content('Inscrição realizada com sucesso!')
        expect(page).not_to have_link(I18n.t('register'))
        expect(page).to have_content(I18n.t('already_registered'))
    end

    scenario 'and must be loged' do
        opportunity = create(:opportunity, title: 'Engenheiro de Software')

        visit opportunities_path
        click_on 'Engenheiro de Software'
        
        expect(page).not_to have_link(I18n.t('register'))
    end

    scenario 'and must be not already registered' do
        candidate = create(:candidate, email: 'candidate@email.com')
        opportunity = create(:opportunity, title: 'Engenheiro de Software')
        create(:subscription, opportunity: opportunity, candidate: candidate)

        login_as(candidate, scope: :candidate)
        visit opportunities_path
        click_on 'Engenheiro de Software'
        
        expect(page).not_to have_link(I18n.t('register'))
        expect(page).to have_content(I18n.t('already_registered'))
    end
end