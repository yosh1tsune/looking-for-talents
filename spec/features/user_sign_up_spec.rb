require 'rails_helper'

feature 'user sign up' do
  scenario 'successfully as headhunter', js: true do
    visit root_path
    click_on 'Login Headhunters'
    click_on 'Inscrever-se'

    fill_in 'Nome', with: 'Bruno'
    fill_in 'Sobrenome', with: 'Silva'
    fill_in 'E-mail', with: 'headhunter@email.com'
    fill_in 'Senha', with: 'head1234'
    fill_in 'Confirme sua senha', with: 'head1234'
    click_on 'Inscrever-se'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Bem vindo! Você realizou seu registro '\
                                 'com sucesso.')
  end

  scenario 'and must fill all fields' do
    visit root_path
    click_on 'Login Headhunters'
    click_on 'Inscrever-se'

    click_on 'Inscrever-se'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Sobrenome não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end

  scenario 'successfully as candidate', js: true do
    visit root_path
    click_on 'Login Candidatos'
    click_on 'Inscrever-se'

    fill_in 'E-mail', with: 'candidate@email.com'
    fill_in 'Senha', with: 'cand1234'
    fill_in 'Confirme sua senha', with: 'cand1234'
    click_on 'Inscrever-se'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Bem vindo! Você realizou seu registro '\
                                 'com sucesso.')
  end

  scenario 'and must fill all fields' do
    visit root_path
    click_on 'Login Candidatos'
    click_on 'Inscrever-se'

    click_on 'Inscrever-se'

    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end
end
