require 'rails_helper'

feature 'Headhunter liks headhunters to his company' do
  scenario 'successfully links himself' do
    headhunter = create(:headhunter, name: 'Bruno', surname: 'Silva',
                                     email: 'headhunter@email.com')
    company = create(:company, name: 'RR System', headhunter: headhunter)

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Empresas'
    click_on company.name
    fill_in 'Email', with: headhunter.email
    click_on 'Vincular'

    expect(page).to have_content('Headhunter vinculado com sucesso!')
    expect(page).to have_content 'Bruno Silva - headhunter@email.com'
    expect(page).to have_button('Remover headhunter')
  end

  scenario 'successfully links another headhunter' do
    owner = create(:headhunter, email: 'owner@email.com')
    headhunter = create(:headhunter, name: 'Bruno', surname: 'Silva',
                                     email: 'headhunter@email.com')
    company = create(:company, name: 'RR System', headhunter: owner)

    login_as(owner, scope: :headhunter)
    visit root_path
    click_on 'Empresas'
    click_on company.name
    fill_in 'Email', with: headhunter.email
    click_on 'Vincular'

    expect(page).to have_content('Headhunter vinculado com sucesso!')
    expect(page).to have_content 'Bruno Silva - headhunter@email.com'
    expect(page).to have_button('Remover headhunter')
  end

  scenario 'and must send a valid headhunter' do
    owner = create(:headhunter, email: 'owner@email.com')
    company = create(:company, name: 'RR System', headhunter: owner)

    login_as(owner, scope: :headhunter)
    visit root_path
    click_on 'Empresas'
    click_on company.name
    fill_in 'Email', with: ''
    click_on 'Vincular'

    expect(page).to have_content('Insira um headhunter com email válido.')
  end
end
