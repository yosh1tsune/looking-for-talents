require 'rails_helper'

feature 'visitor visit home index' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('DE DEVS PARA DEVS')
  end

  scenario 'and visualize the latest three opportunities' do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)
    another_opportunity = create(:opportunity, title: 'Analista de suporte',
                                               headhunter: headhunter)
    third_opportunity = create(:opportunity, title: 'Engenheiro de Software',
                                             headhunter: headhunter)
    fouth_opportunity = create(:opportunity, title: 'Desenvolvedor Front-End',
                                             headhunter: headhunter)

    login_as(candidate, scope: :candidate)
    visit root_path

    expect(page).to have_content(opportunity.title)
    expect(page).to have_content(another_opportunity.title)
    expect(page).to have_content(third_opportunity.title)
    expect(page).not_to have_content(fouth_opportunity.title)
  end
end
