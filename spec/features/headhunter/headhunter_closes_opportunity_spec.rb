require 'rails_helper'

feature 'headhunter closes opportunity' do
  scenario 'successfully' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Vagas'
    click_on opportunity.title
    click_on 'Encerrar inscrições'

    expect(page).to have_content(opportunity.work_description)
    expect(page).to have_content("#{I18n.t('work_description')}: "\
                                 "#{opportunity.work_description}")
    expect(page).to have_content("#{I18n.t('required_abilities')}: "\
                                 "#{opportunity.required_abilities}")
    expect(page).to have_content("#{I18n.t('salary')}: #{opportunity.salary}")
    expect(page).to have_content("#{I18n.t('submit_end_date')}: "\
                                 "#{I18n.l(opportunity.submit_end_date)}")
    expect(page).to have_content("#{I18n.t('grade')}: #{opportunity.grade}")
    expect(page).not_to have_link('Encerrar inscrições')
  end

  scenario 'and must see only his opportunities' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    another_headhunter = create(:headhunter,
                                email: 'another_headhunter@email.com')
    opportunity = create(:opportunity,
                         title: 'Desenvolvedor Júnior Ruby on Rails',
                         headhunter: headhunter)
    another_opportunity = create(:opportunity, title: 'Engenheiro de software',
                                               headhunter: another_headhunter)

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Vagas'

    expect(page).to have_content(opportunity.title)
    expect(page).not_to have_content(another_opportunity.title)
  end
end
