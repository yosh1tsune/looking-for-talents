require 'rails_helper'

feature 'headhunter publish opportunity' do
    scenario 'successfully' do
        headhunter = Headhunter.create(email: 'headhunter@email.com', password: 'head1234')

        login_as(headhunter)
        visit root_path
        click_on 'Vagas'
        click_on 'Publicar vaga'

        fill_in 'Título', with: 'Desenvolvedor Júnior Ruby on Rails'
        fill_in 'Descrição da vaga', with: 'Desenvolvimento de aplicações web com Ruby on Rails'
        fill_in 'Habilidades necessárias', with: 'Ruby, Rails, TDD, JavaScript, Bancos de Dados, HTML, CSS'
        fill_in 'Salário', with: 'À combinar'
        fill_in 'Data de encerramento das inscrições', with: '14/01/2020'
        fill_in 'Nível', with: 'Junior'
        fill_in 'Endereço', with: 'Avenida Paulista, 1000 - Bela Vista'
        click_on 'Enviar'

        expect(page).to have_content('Desenvolvedor Júnior Ruby on Rails')
        expect(page).to have_content("#{I18n.t('work_description')}: Desenvolvimento de aplicações web com Ruby on Rails")
        expect(page).to have_content("#{I18n.t('required_abilities')}: Ruby, Rails, TDD, JavaScript, Bancos de Dados, HTML, CSS")
        expect(page).to have_content("#{I18n.t('salary')}: À combinar")
        expect(page).to have_content("#{I18n.t('submit_end_date')}: 14/01/2020")
        expect(page).to have_content("#{I18n.t('grade')}: Junior")
        expect(page).to have_content("#{I18n.t('address')}: Avenida Paulista, 1000 - Bela Vista")
        expect(page).to have_content('Vaga publicada com sucesso!')
    end

    scenario 'and must fill all fields' do
        headhunter = Headhunter.create(email: 'headhunter@email.com', password: 'head1234')

        login_as(headhunter)
        visit root_path
        click_on 'Vagas'
        click_on 'Publicar vaga'

        fill_in 'Título', with: 'Desenvolvedor Júnior Ruby on Rails'
        fill_in 'Descrição da vaga', with: 'Desenvolvimento de aplicações web com Ruby on Rails'
        fill_in 'Habilidades necessárias', with: 'Ruby, Rails, TDD, JavaScript, Bancos de Dados, HTML, CSS'
        fill_in 'Salário', with: 'À combinar'
        fill_in 'Data de encerramento das inscrições', with: 14.days.from_now
        fill_in 'Nível', with: ''
        fill_in 'Endereço', with: 'Avenida Paulista, 1000 - Bela Vista'
        click_on 'Enviar'

        expect(page).to have_content('Nível não pode ficar em branco')
    end
end