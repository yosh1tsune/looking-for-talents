require 'rails_helper'

feature 'Headhunter liks headhunters to his company', js: true do
  let(:owner_headhunter) { create(:headhunter, name: 'Bruno', surname: 'Silva', email: 'owner@email.com') }
  let!(:company) { create(:company, name: 'RR System', headhunter: headhunter) }
  let!(:headhunter) { create(:headhunter, email: 'headhunter@email.com') }

  scenario 'successfully links himself' do
    login_as(owner_headhunter, scope: :headhunter)
    visit root_path
    click_on 'Empresas'
    click_on 'RR System'
    fill_in 'Email', with: owner_headhunter.email
    click_on 'Vincular'

    expect(page).to have_content 'Headhunter vinculado com sucesso!'
    expect(page).to have_content owner_headhunter.details
    expect(page).to have_button 'Remover headhunter'
  end

  scenario 'successfully links another headhunter' do
    login_as(owner_headhunter, scope: :headhunter)
    visit root_path
    click_on 'Empresas'
    click_on 'RR System'
    fill_in 'Email', with: headhunter.email
    click_on 'Vincular'

    expect(page).to have_content 'Headhunter vinculado com sucesso!'
    expect(page).to have_content headhunter.details
    expect(page).to have_button 'Remover headhunter'
  end

  scenario 'and must send a valid headhunter' do
    login_as(owner_headhunter, scope: :headhunter)
    visit root_path
    click_on 'Empresas'
    click_on 'RR System'
    fill_in 'Email', with: ''
    click_on 'Vincular'

    expect(page).to have_content 'Insira um headhunter com email válido.'
  end
end
