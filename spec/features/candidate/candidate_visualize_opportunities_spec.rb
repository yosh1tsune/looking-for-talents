require 'rails_helper'

feature 'candidate visualize opportunities' do
  scenario 'list at index' do
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

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Vagas'

    expect(page).to have_content(opportunity.title)
    expect(page).to have_content("Nível: #{opportunity.grade}")
    expect(page).to have_content(another_opportunity.title)
    expect(page).to have_content('Nível: '\
                                 "#{another_opportunity.grade}")
    expect(page).to have_content(third_opportunity.title)
    expect(page).to have_content('Nível: '\
                                 "#{third_opportunity.grade}")
  end

  scenario 'and choose one' do
    candidate = create(:candidate, email: 'candidate@email.com')
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    login_as(candidate, scope: :candidate)
    visit opportunities_path
    click_on 'Desenvolvedor Júnior Ruby on Rails'

    expect(page).to have_content(opportunity.title)
    expect(page).to have_content('Descrição da vaga: '\
                                 "#{opportunity.work_description}")
    expect(page).to have_button('Inscreva-se')
  end
end
