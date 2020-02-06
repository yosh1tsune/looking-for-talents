require 'rails_helper'

feature 'headhunter highlight candidate'do
    scenario 'successfully' do
        candidate = create(:candidate, email: 'candidate@email.com')
        headhunter = create(:headhunter, email: 'headhunter@email.com')
        profile = create(:profile, name: 'Bruno Silva', candidate: candidate)
                                
        opportunity = create(:opportunity, title: 'Desenvolvedor Júnior Ruby on Rails', headhunter: headhunter)

        subscription = create(:subscription, opportunity: opportunity, candidate: candidate, highlighted: false)

        login_as(headhunter, scope: :headhunter)
        visit opportunities_path
        click_on opportunity.title
        click_on subscription.id
        click_on 'Destacar perfil'

        expect(page).to have_content(subscription.opportunity.title)
        expect(page).to have_content(subscription.profile.name)
        expect(page).to have_content(subscription.status)
        expect(page).to have_link 'Remover destaque'
    end

    scenario 'and remove hightlights successfully' do
        candidate = create(:candidate, email: 'candidate@email.com')
        headhunter = create(:headhunter, email: 'headhunter@email.com')
        profile = create(:profile, name: 'Bruno Silva', candidate: candidate)
                                
        opportunity = create(:opportunity, title: 'Desenvolvedor Júnior Ruby on Rails', headhunter: headhunter)

        subscription = create(:subscription, opportunity: opportunity, candidate: candidate, highlighted: true)

        login_as(headhunter, scope: :headhunter)
        visit opportunities_path
        click_on opportunity.title
        click_on subscription.id
        click_on 'Remover destaque'

        expect(page).to have_content(subscription.opportunity.title)
        expect(page).to have_content(subscription.profile.name)
        expect(page).to have_content(subscription.status)
        expect(page).to have_link 'Destacar perfil'
    end
end