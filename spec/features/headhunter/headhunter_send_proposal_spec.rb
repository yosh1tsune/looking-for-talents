require 'rails_helper'

feature 'headhunter send proposal' do
  scenario 'successfully approve', js: true do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate,
                                         status: :approved)

    login_as(headhunter, scope: :headhunter)
    visit opportunities_path
    click_on opportunity.title
    click_on subscription.opportunity.title
    fill_in 'Data de início', with: '01/02/2030'
    fill_in 'Salário', with: 2800
    fill_in 'Cargo', with: 'Desenvolvedor Júnior'
    fill_in 'Benefícios', with: 'Vale Transporte, Vale Refeição, '\
                                'Convênio Médico'
    fill_in 'Expectativas', with: 'Colaborar com as rotinas de testes '\
                                  'do time de desenvolvimento'
    fill_in 'Bônus', with: 'Participação de lucros'
    click_on 'Enviar proposta'

    expect(page).to have_content('Proposta enviada!')
    expect(page).to have_content("Proposta para a vaga: #{opportunity.title}")
    expect(page).to have_content("Data de início:\n01/02/2030")
  end

  scenario 'and must fill all fields', js: true do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate,
                                         status: :approved)

    login_as(headhunter, scope: :headhunter)
    visit opportunities_path
    click_on opportunity.title
    click_on subscription.opportunity.title
    fill_in 'Data de início', with: '01/02/2020'
    fill_in 'Salário', with: 2800
    fill_in 'Cargo', with: 'Desenvolvedor Júnior'
    fill_in 'Benefícios', with: 'Vale Transporte, Vale Refeição, '\
                                      'Convênio Médico'
    fill_in 'Expectativas', with: 'Colaborar com as rotinas de testes '\
                                          'do time de desenvolvimento'
    fill_in 'Bônus', with: ''
    click_on 'Enviar proposta'

    expect(page).to have_content('Proposta não enviada, preencha todos '\
                                 'os campos!')
  end
end
