require 'rails_helper'

feature 'user sign up' do
    scenario 'successfully as headhunter' do
        visit root_path
        click_on 'Login Headhunters'
        click_on 'Inscrever-se'

        fill_in 'E-mail', with: 'headhunter@email.com'
        fill_in 'Senha', with: 'head1234'
        fill_in 'Confirme sua senha', with: 'head1234'
        click_on 'Inscrever-se'


        expect(current_path).to eq(root_path)
        expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')
    end

    scenario 'successfully as candidate' do
        visit root_path
        click_on 'Login Candidatos'
        click_on 'Inscrever-se'

        fill_in 'E-mail', with: 'candidate@email.com'
        fill_in 'Senha', with: 'cand1234'
        fill_in 'Confirme sua senha', with: 'cand1234'
        click_on 'Inscrever-se'

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Bem vindo! Você realizou seu registro com sucesso.')        
    end
end