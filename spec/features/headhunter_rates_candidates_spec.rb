require 'rails_helper'

feature 'headhunter rates candidates' do
    scenario 'successfully approve' do
        candidate = create(:candidate, email: 'candidate@email.com')
        headhunter = create(:headhunter, email: 'headhunter@email.com')
        profile = create(:profile, name: 'Bruno Silva', candidate: candidate)
                                  
        opportunity = create(:opportunity, title: 'Desenvolvedor Júnior Ruby on Rails', headhunter: headhunter)

        subscription = create(:subscription, opportunity: opportunity, candidate: candidate)

        login_as(headhunter, scope: :headhunter)
        visit opportunities_path
        click_on 'Desenvolvedor Júnior Ruby on Rails'
        click_on "#{subscription.id}"
        fill_in I18n.t('feedback'), with: 'Sua experiência condiz com o requerido'
        select :approved, from: I18n.t('status')
        click_on 'Avaliar'
        
        expect(page).to have_content('Inscrição atualizada com sucesso')
        expect(page).to have_content("#{I18n.t('status')}: #{I18n.t('approved')}")
        expect(page).to have_content("#{I18n.t('feedback')}: #{subscription.feedback}")
    end

    scenario 'successfully refuse' do
        candidate = create(:candidate, email: 'candidate@email.com')
        headhunter = create(:headhunter, email: 'headhunter@email.com')
        profile = create(:profile, name: 'Bruno Silva', candidate: candidate)
                                  
        opportunity = create(:opportunity, title: 'Desenvolvedor Júnior Ruby on Rails', headhunter: headhunter)

        subscription = create(:subscription, opportunity: opportunity, candidate: candidate)

        login_as(headhunter, scope: :headhunter)
        visit opportunities_path
        click_on 'Desenvolvedor Júnior Ruby on Rails'
        click_on "#{subscription.id}"
        fill_in I18n.t('feedback'), with: 'Precisamos de alguém com experiência em Rails'
        select :refuse, from: I18n.t('status')
        click_on 'Avaliar'
        
        expect(page).to have_content('Inscrição atualizada com sucesso')
        expect(page).to have_content("#{I18n.t('status')}: #{I18n.t('refused')}")
        expect(page).to have_content("#{I18n.t('feedback')}: #{subscription.feedback}")
    end
end