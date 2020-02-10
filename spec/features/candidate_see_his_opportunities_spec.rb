require 'rails_helper'

feature 'candidate see his opportunities and feedbacks' do
  scenario 'successfully while in progress' do
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

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas vagas'

    expect(page).to have_content(subscription.opportunity.title)
    expect(page).to have_content('Status: Em andamento')

    expect(page).to have_content(another_subscription.opportunity.title)
    expect(page).to have_content('Status: Em andamento')
  end

  scenario 'successfully if refused' do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate,
                                         registration_resume: '1 ano de estágio
                                                      com desenvolvimento web',
                                         status: 2,
                                         feedback: 'Pouca experiência')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas vagas'

    expect(page).to have_content(subscription.opportunity.title)
    expect(page).to have_content('Status: Recusada')
    expect(page).to have_content("Feedback: #{subscription.feedback}")
  end

  scenario 'successfully if approved' do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    subscription = create(:subscription, opportunity: opportunity,
                                         candidate: candidate,
                                         registration_resume: '1 ano de estágio
                                                      com desenvolvimento web',
                                         status: 1,
                                         feedback: 'Parabéns, você foi '\
                                                   'aprovado!')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas vagas'

    expect(page).to have_content(subscription.opportunity.title)
    expect(page).to have_content('Status: Aprovado')
    expect(page).to have_content("Feedback: #{subscription.feedback}")
  end

  scenario "and unsuccessfully if there's no registrations" do
    candidate = create(:candidate, email: 'candidate@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Minhas vagas'

    expect(page).to have_content('Você ainda não se inscreveu em nenhuma vaga')
  end
end
