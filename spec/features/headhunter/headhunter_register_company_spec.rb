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
    fill_in 'Logradouro', with: 'Avenida Paulista, 1000'
    fill_in 'Bairro', with: 'Bela Vista'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'País', with: 'Brasil'
    fill_in 'CEP', with: '00000-000'
    attach_file 'Logotipo', Rails.root.join('spec/support/company.png')
    click_on 'Enviar'

    expect(page).to have_content('Empresa cadastrada com sucesso!')
    expect(page).to have_content('RR System')
    expect(page).to have_css("img[src*='company.png']")
    expect(page).to have_content("#{I18n.t('companies.show.document')}:"\
                                 "\n66.864.712/0001-67")
    expect(page).to have_content("#{I18n.t('street')}:\nAvenida Paulista, "\
                                 '1000')
    expect(page).to have_content("#{I18n.t('zipcode')}:\n00000-000")
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
