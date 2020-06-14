require 'rails_helper'

feature 'headhunter send proposal' do
  scenario 'successfully approve' do
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
    fill_in I18n.t('start_date'), with: '01/02/2030'
    fill_in I18n.t('salary'), with: 2800
    fill_in I18n.t('role'), with: 'Desenvolvedor Júnior'
    fill_in I18n.t('benefits'), with: 'Vale Transporte, Vale Refeição, '\
                                      'Convênio Médico'
    fill_in I18n.t('expectations'), with: 'Colaborar com as rotinas de testes '\
                                          'do time de desenvolvimento'
    fill_in I18n.t('bonuses'), with: 'Participação de lucros'
    click_on 'Enviar proposta'

    expect(page).to have_content('Proposta enviada!')
    expect(page).to have_content("Proposta para a vaga: #{opportunity.title}")
    expect(page).to have_content("#{I18n.t('start_date')}: 01/02/2030")
  end

  scenario 'and must fill all fields' do
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
    fill_in I18n.t('start_date'), with: '01/02/2020'
    fill_in I18n.t('salary'), with: 2800
    fill_in I18n.t('role'), with: 'Desenvolvedor Júnior'
    fill_in I18n.t('benefits'), with: 'Vale Transporte, Vale Refeição, '\
                                      'Convênio Médico'
    fill_in I18n.t('expectations'), with: 'Colaborar com as rotinas de testes '\
                                          'do time de desenvolvimento'
    fill_in I18n.t('bonuses'), with: ''
    click_on 'Enviar proposta'

    expect(page).to have_content('Proposta não enviada, preencha todos '\
                                 'os campos!')
  end
end
