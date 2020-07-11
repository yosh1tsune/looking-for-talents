require 'rails_helper'

feature 'headhunter rates candidates' do
  scenario 'successfully approve', js: true do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate)

    login_as(headhunter, scope: :headhunter)
    visit opportunities_path
    click_on 'Desenvolvedor Júnior Ruby on Rails'
    click_on subscription.opportunity.title
    fill_in 'Feedback', with: 'Sua experiência condiz com o requerido'
    select :approved, from: 'Status'
    click_on 'Avaliar'

    expect(page).to have_content('Inscrição atualizada com sucesso')
    expect(page).to have_content("Status:\nAprovado")
    expect(page).to have_content("Feedback:\n#{subscription.feedback}")
  end

  scenario 'successfully refuse', js: true do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate)

    login_as(headhunter, scope: :headhunter)
    visit opportunities_path
    click_on 'Desenvolvedor Júnior Ruby on Rails'
    click_on subscription.opportunity.title
    fill_in 'Feedback', with: 'Precisamos de alguém com experiência em Rails'
    select :refuse, from: 'Status'
    click_on 'Avaliar'

    expect(page).to have_content('Inscrição atualizada com sucesso')
    expect(page).to have_content("Status:\nRecusado")
    expect(page).to have_content("Feedback:\n#{subscription.feedback}")
  end

  scenario 'and must fill all fields', js: true do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate)

    login_as(headhunter, scope: :headhunter)
    visit opportunities_path
    click_on 'Desenvolvedor Júnior Ruby on Rails'
    click_on subscription.opportunity.title
    fill_in 'Feedback', with: ''
    click_on 'Avaliar'

    expect(page).to have_content('Altere o status da inscrição e preencha o '\
                                                                    'feedback')
  end
end
