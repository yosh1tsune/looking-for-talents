require 'rails_helper'

feature 'candidate see proposals' do
  scenario 'successfully' do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate,
                                         status: :approved)

    proposal = create(:proposal, role: 'Desenvolvedor Ruby on Rails',
                                 subscription: subscription,
                                 opportunity: opportunity)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas propostas'

    expect(page).to have_content("Vaga: #{proposal.opportunity.title}")
    expect(page).to have_content("Cargo: #{proposal.role}")
  end

  scenario 'and choose one' do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    another_opportunity = create(:opportunity, title: 'Engenheiro de Software',
                                               headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate)

    another_subscription = create(:subscription,
                                  opportunity: another_opportunity,
                                  candidate: candidate)

    proposal = create(:proposal, role: 'Desenvolvedor Ruby on Rails',
                                 subscription: subscription,
                                 opportunity: opportunity)

    create(:proposal, role: 'Analista de suporte',
                      subscription: another_subscription,
                      opportunity: another_opportunity)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas propostas'
    click_on proposal.role

    expect(page).to have_content('Proposta para a vaga: '\
                                 "#{proposal.opportunity.title}")
    expect(page).to have_content('Data de início: '\
                                 "#{I18n.l(proposal.start_date)}")
    expect(page).to have_content('Status: Em andamento')
    expect(page).to have_link('Aceitar proposta')
    expect(page).to have_link('Recusar proposta')
  end

  scenario 'and refuse :(' do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    another_opportunity = create(:opportunity, title: 'Engenheiro de Software',
                                               headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate)

    another_subscription = create(:subscription,
                                  opportunity: another_opportunity,
                                  candidate: candidate)

    proposal = create(:proposal, role: 'Desenvolvedor Ruby on Rails',
                                 subscription: subscription,
                                 opportunity: opportunity)

    create(:proposal, role: 'Analista de suporte',
                      subscription: another_subscription,
                      opportunity: another_opportunity)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas propostas'
    click_on proposal.role
    click_on 'Recusar proposta'

    expect(page).to have_content('Proposta para a vaga: '\
                                 "#{proposal.opportunity.title}")
    expect(page).to have_content('Data de início: '\
                                 "#{I18n.l(proposal.start_date)}")
    expect(page).to have_content('Status: Recusada')
    expect(page).not_to have_link('Aceitar proposta')
    expect(page).not_to have_link('Recusar proposta')
  end

  scenario 'OR ACCEPT :D' do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    another_opportunity = create(:opportunity, title: 'Engenheiro de Software',
                                               headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate)

    another_subscription = create(:subscription,
                                  opportunity: another_opportunity,
                                  candidate: candidate)

    proposal = create(:proposal, role: 'Desenvolvedor Ruby on Rails',
                                 subscription: subscription,
                                 opportunity: opportunity)

    create(:proposal, role: 'Analista de suporte',
                      subscription: another_subscription,
                      opportunity: another_opportunity)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas propostas'
    click_on proposal.role
    click_on 'Aceitar proposta'

    expect(page).to have_content('Proposta para a vaga: '\
                                 "#{proposal.opportunity.title}")
    expect(page).to have_content('Data de início: '\
                                 "#{I18n.l(proposal.start_date)}")
    expect(page).to have_content('Status: Aceita')
    expect(page).not_to have_link('Aceitar proposta')
    expect(page).not_to have_link('Recusar proposta')
  end

  scenario 'and check if the other are refused' do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    another_opportunity = create(:opportunity, title: 'Engenheiro de Software',
                                               headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate)

    another_subscription = create(:subscription,
                                  opportunity: another_opportunity,
                                  candidate: candidate)

    proposal = create(:proposal, role: 'Desenvolvedor Ruby on Rails',
                                 subscription: subscription,
                                 opportunity: opportunity)

    another_proposal = create(:proposal, role: 'Analista de suporte',
                                         subscription: another_subscription,
                                         opportunity: another_opportunity)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas propostas'
    click_on proposal.role
    click_on 'Aceitar proposta'
    visit proposals_path

    expect(page).to have_content("Vaga: #{proposal.opportunity.title}")
    expect(page).to have_content("Cargo: #{proposal.role}")
    expect(page).to have_content('Status: Aceita')
    expect(page).to have_content("Vaga: #{another_proposal.opportunity.title}")
    expect(page).to have_content("Cargo: #{another_proposal.role}")
    expect(page).to have_content('Status: Recusada')
  end
end
