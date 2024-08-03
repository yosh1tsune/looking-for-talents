require 'rails_helper'

feature 'headhunter see candidates' do
  scenario 'successfully from profiles#index' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    candidate = create(:candidate, email: 'candidate@email.com')
    profile = create(:profile, name: 'Bruno Silva', candidate: candidate)

    another_candidate = create(:candidate, email: 'another_candidate@email.com')
    another_profile = create(:profile, name: 'João Carlos',
                                       candidate: another_candidate)

    third_candidate = create(:candidate, email: 'third_candidate@email.com')
    third_profile = create(:profile, name: 'Julia Amorim',
                                     candidate: third_candidate)

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Perfis'

    expect(page).to have_content(profile.name)
    expect(page).to have_content(profile.professional_resume)
    expect(page).to have_content(another_profile.name)
    expect(page).to have_content(another_profile.professional_resume)
    expect(page).to have_content(third_profile.name)
    expect(page).to have_content(third_profile.professional_resume)
  end

  scenario 'unsuccessfully on profiles#index if none profile registered' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Perfis'

    expect(page).to have_content('Ainda não há perfis cadastrados')
  end

  scenario 'successfully from opportunity#show when candidates registered' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    candidate = create(:candidate, email: 'candidate@email.com')
    profile = create(:profile, name: 'Bruno Silva', candidate: candidate)

    another_candidate = create(:candidate, email: 'another_candidate@email.com')
    another_profile = create(:profile, name: 'João Carlos',
                                       candidate: another_candidate)

    third_candidate = create(:candidate, email: 'third_candidate@email.com')
    third_profile = create(:profile, name: 'Julia Amorim',
                                     candidate: third_candidate)
    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate)
    another_subscription = create(:subscription, opportunity: opportunity,
                                                 candidate: another_candidate)
    third_subscription = create(:subscription, opportunity: opportunity,
                                               candidate: third_candidate)

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Vagas'
    find('h5', text: opportunity.title).click_link

    expect(page).to have_content(profile.name)
    expect(page).to have_content(subscription.registration_resume)
    expect(page).to have_content(another_profile.name)
    expect(page).to have_content(another_subscription.registration_resume)
    expect(page).to have_content(third_profile.name)
    expect(page).to have_content(third_subscription.registration_resume)
  end

  scenario 'and visualize their profiles' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    candidate = create(:candidate, email: 'candidate@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    another_candidate = create(:candidate, email: 'another_candidate@email.com')
    another_profile = create(:profile, name: 'Carlos Souza',
                                       candidate: another_candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    create(:subscription, opportunity: opportunity, candidate: candidate)
    create(:subscription, opportunity: opportunity,
                          candidate: another_candidate)

    login_as(headhunter, scope: :headhunter)
    visit opportunities_path
    find('h5', text: opportunity.title).click_link
    find('dd', text: another_profile.name).click_link

    expect(page).to have_content(another_profile.name)
    expect(page).to have_content('Data de nascimento: '\
                                 "#{I18n.l(another_profile.birth_date)}")
    expect(page).to have_content("CPF: #{another_profile.document}")
    expect(page).to have_content("Escolaridade: #{another_profile.scholarity}")
    expect(page).to have_content('Resumo profissional: '\
                                 "#{another_profile.professional_resume}")
  end
end
