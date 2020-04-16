require 'rails_helper'

feature 'candidate updates profile' do
  scenario "candidate still don't have profile" do
    candidate = create(:candidate, email: 'candidate@email.com')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'

    expect(page).to have_content('Complete seu perfil')
    expect(current_path).to eq(new_profile_path)
  end

  scenario 'and create if not' do
    candidate = create(:candidate, email: 'candidate@email.com')

    login_as(candidate)
    visit root_path
    click_on 'Perfil'

    fill_in I18n.t('name'), with: 'Bruno Silva'
    fill_in I18n.t('birth_date'), with: '22/04/1996'
    fill_in I18n.t('document'), with: '996.490.558-00'
    fill_in I18n.t('scholarity'), with: 'Superior Incompleto'
    fill_in I18n.t('professional_resume'), with: 'Desenvolvimento web com Dart2'
    fill_in I18n.t('address'), with: 'Alameda Santos, 1293'
    attach_file 'Avatar', Rails.root.join('spec/support/user.jpg')
    click_on 'Enviar'

    expect(page).to have_content('Perfil atualizado com sucesso')
    expect(page).to have_content('Bruno Silva')
    expect(page).to have_content("#{I18n.t('birth_date')}: 22/04/1996")
    expect(page).to have_content("#{I18n.t('document')}: 996.490.558-00")
    expect(page).to have_content("#{I18n.t('scholarity')}: Superior Incompleto")
    expect(page).to have_content("#{I18n.t('professional_resume')}: "\
                                 'Desenvolvimento web com Dart2')
    expect(page).to have_css("img[src*='user.jpg']")
    expect(page).to have_content("#{I18n.t('address')}: Alameda Santos, 1293")
  end

  scenario 'and must fill all fields' do
    candidate = create(:candidate, email: 'candidate@email.com')

    login_as(candidate)
    visit root_path
    click_on 'Perfil'

    fill_in I18n.t('name'), with: 'Bruno Silva'
    fill_in I18n.t('birth_date'), with: ''
    fill_in I18n.t('document'), with: '996.490.558-00'
    fill_in I18n.t('scholarity'), with: ''
    fill_in I18n.t('professional_resume'), with: 'Desenvolvimento web com Dart2'
    fill_in I18n.t('address'), with: 'Alameda Santos, 1293'
    attach_file 'Avatar', Rails.root.join('spec/support/user.jpg')
    click_on 'Enviar'

    expect(page).to have_content("#{I18n.t('birth_date')} não pode ficar em "\
                                                                      'branco')
    expect(page).to have_content("#{I18n.t('scholarity')} não pode ficar em "\
                                                                      'branco')
  end

  scenario 'or edit if already have' do
    candidate = create(:candidate, email: 'candidate@email.com')
    create(:profile, name: 'Bruno Silva',
                     birth_date: '22/04/1996',
                     document: '996.490.558-00',
                     scholarity: 'Superior Incompleto',
                     professional_resume: 'Desenvolvimento web com Dart 2',
                     address: 'Alameda Santos, 1293',
                     candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'
    click_on 'Editar perfil'
    fill_in I18n.t('professional_resume'), with: 'Desenvolvimento web com '\
                                                 'Dart 2, Rails, TDD'
    fill_in I18n.t('address'), with: 'Avenida Paulista, 1000'
    click_on 'Enviar'

    expect(page).to have_content('Perfil atualizado com sucesso')
    expect(page).to have_content('Bruno Silva')
    expect(page).to have_content("#{I18n.t('birth_date')}: 22/04/1996")
    expect(page).to have_content("#{I18n.t('document')}: 996.490.558-00")
    expect(page).to have_content("#{I18n.t('scholarity')}: Superior Incompleto")
    expect(page).to have_content("#{I18n.t('professional_resume')}: "\
                                 'Desenvolvimento web com Dart 2, Rails, TDD')
    expect(page).to have_content("#{I18n.t('address')}: Avenida Paulista, 1000")
  end

  scenario 'and must fill all fields' do
    candidate = create(:candidate, email: 'candidate@email.com')
    create(:profile, name: 'Bruno Silva', candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'
    click_on 'Editar perfil'

    fill_in I18n.t('name'), with: 'Bruno Silva'
    fill_in I18n.t('birth_date'), with: '22/04/1996'
    fill_in I18n.t('document'), with: '996.490.558-00'
    fill_in I18n.t('scholarity'), with: 'Superior Incompleto'
    fill_in I18n.t('professional_resume'), with: 'Desenvolvimento web com '\
                                                 'Dart 2, Ruby on Rails, TDD'
    fill_in I18n.t('address'), with: ''
    click_on 'Enviar'

    expect(current_path).to eq profile_path(candidate)
    expect(page).to have_content("#{I18n.t('address')} "\
                                 'não pode ficar em branco')
  end
end
