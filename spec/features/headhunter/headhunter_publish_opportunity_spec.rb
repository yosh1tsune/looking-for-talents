require 'rails_helper'

feature 'headhunter publish opportunity' do
  scenario 'successfully' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Vagas'
    click_on 'Publicar vaga'

    fill_in I18n.t('title'), with: 'Desenvolvedor Júnior Ruby on Rails'
    fill_in I18n.t('company'), with: 'RR System'
    fill_in I18n.t('work_description'), with: 'Desenvolvimento web com '\
                                              'Ruby on Rails'
    fill_in I18n.t('required_abilities'), with: 'Ruby, Rails, TDD, JavaScript,'\
                                                ' HTML, CSS'
    fill_in I18n.t('salary'), with: 'À combinar'
    fill_in I18n.t('submit_end_date'), with: 7.days.from_now
    fill_in I18n.t('grade'), with: 'Junior'
    fill_in I18n.t('address'), with: 'Avenida Paulista, 1000 - Bela Vista'
    click_on 'Enviar'

    expect(page).to have_content('Desenvolvedor Júnior Ruby on Rails')
    expect(page).to have_content("#{I18n.t('company')}: RR System")
    expect(page).to have_content("#{I18n.t('work_description')}: "\
                                 'Desenvolvimento web com Ruby on Rails')
    expect(page).to have_content("#{I18n.t('required_abilities')}: "\
                                 'Ruby, Rails, TDD, JavaScript, HTML, CSS')
    expect(page).to have_content("#{I18n.t('salary')}: À combinar")
    expect(page).to have_content("#{I18n.t('submit_end_date')}: "\
                                 "#{7.days.from_now.strftime('%d/%m/%Y')}")
    expect(page).to have_content("#{I18n.t('grade')}: Junior")
    expect(page).to have_content("#{I18n.t('address')}: Avenida Paulista, "\
                                 '1000 - Bela Vista')
    expect(page).to have_content('Vaga publicada com sucesso!')
  end

  scenario 'and must fill all fields' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    login_as(headhunter, scope: :headhunter)
    visit opportunities_path
    click_on 'Publicar vaga'

    fill_in I18n.t('title'), with: 'Desenvolvedor Júnior Ruby on Rails'
    fill_in I18n.t('company'), with: 'RR System'
    fill_in I18n.t('work_description'), with: 'Desenvolvimento de aplicações '\
                                              'web com Ruby on Rails'
    fill_in I18n.t('required_abilities'), with: 'Ruby, Rails, TDD, JavaScript,'\
                                                'Bancos de Dados, HTML, CSS'
    fill_in I18n.t('salary'), with: 'À combinar'
    fill_in I18n.t('submit_end_date'), with: 14.days.from_now
    fill_in I18n.t('grade'), with: ''
    fill_in I18n.t('address'), with: 'Avenida Paulista, 1000 - Bela Vista'
    click_on 'Enviar'

    expect(page).to have_content('Nível não pode ficar em branco')
  end
end