require 'rails_helper'

feature 'Headhunter register company' do
  scenario 'succesfully', js: true do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Empresas'
    click_on 'Cadastrar empresa'
    fill_in 'Nome', with: 'RR System'
    fill_in 'CNPJ', with: '66.864.712/0001-67'
    fill_in 'Descrição', with: 'Soluções para desenvolvimento de apps em Ruby'
    fill_in 'Telefone', with: '(11) 99999-9999'
    fill_in 'Email', with: 'recrutamento@rrsystem.com.br'
    click_on 'Enviar'

    expect(page).to have_content('Empresa cadastrada com sucesso!')
    expect(page).to have_content('RR System')
    expect(page).to have_content('CNPJ: 66.864.712/0001-67')
  end

  scenario 'and must fill all fields' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Empresas'
    click_on 'Cadastrar empresa'
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
