require 'rails_helper'

feature 'headhunter verify sent proposals' do
  scenario 'successfully' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    profile = create(:profile)
    subscription = create(:subscription, candidate: profile.candidate)
    proposal = create(:proposal, role: 'Analista de suporte',
                                 headhunter: headhunter,
                                 subscription: subscription)

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Propostas'

    expect(page).to have_content(proposal.role)
  end

  scenario 'and must see only his sent proposals' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    profile = create(:profile)
    subscription = create(:subscription, candidate: profile.candidate)
    proposal = create(:proposal, role: 'Analista de suporte',
                                 headhunter: headhunter,
                                 subscription: subscription)

    another_headhunter = create(:headhunter, email: 'another_head@email.com')
    another_profile = create(:profile)
    another_subs = create(:subscription, candidate: another_profile.candidate)
    another_proposal = create(:proposal, role: 'Desenvolvedor Junior',
                                         headhunter: another_headhunter,
                                         subscription: another_subs)

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Propostas'

    expect(page).to have_content(proposal.role)
    expect(page).not_to have_content(another_proposal.role)
  end
end
