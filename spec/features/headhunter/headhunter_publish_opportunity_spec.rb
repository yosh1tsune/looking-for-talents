require 'rails_helper'

feature 'headhunter publish opportunity' do
  scenario 'successfully' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    company = create(:company, name: 'RR System')
    create(:servicing_headhunter, headhunter: headhunter, company: company)

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Vagas'
    click_on 'Publicar vaga'

    fill_in I18n.t('title'), with: 'Desenvolvedor Júnior Ruby on Rails'
    select 'RR System', from: I18n.t('company_id')
    fill_in I18n.t('work_description'), with: 'Desenvolvimento web com '\
                                              'Ruby on Rails'
    fill_in I18n.t('required_abilities'), with: 'Ruby, Rails, TDD, JavaScript,'\
                                                ' HTML, CSS'
    fill_in I18n.t('salary'), with: 'À combinar'
    fill_in I18n.t('submit_end_date'), with: 7.days.from_now
    fill_in I18n.t('grade'), with: 'Junior'
    click_on 'Enviar'

    expect(page).to have_content('Desenvolvedor Júnior Ruby on Rails')
    expect(page).to have_content("#{I18n.t('submit_end_date')}: "\
                                 "#{7.days.from_now.strftime('%d/%m/%Y')}")
    expect(page).to have_content('Vaga publicada com sucesso!')
  end

  scenario 'and must fill all fields' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    login_as(headhunter, scope: :headhunter)
    visit opportunities_path
    click_on 'Publicar vaga'

    fill_in I18n.t('title'), with: ''
    click_on 'Enviar'

    expect(page).to have_content('Título não pode ficar em branco')
  end
end
