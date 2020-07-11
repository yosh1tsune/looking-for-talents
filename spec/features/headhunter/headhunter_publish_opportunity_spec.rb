require 'rails_helper'

feature 'headhunter publish opportunity' do
  scenario 'successfully', js: true do
    headhunter = create(:headhunter, email: 'headhunter@email.com')
    company = create(:company, name: 'RR System')
    create(:servicing_headhunter, headhunter: headhunter, company: company)

    login_as(headhunter, scope: :headhunter)
    visit root_path
    click_on 'Vagas'
    click_on 'Publicar vaga'

    fill_in 'Título', with: 'Desenvolvedor Júnior Ruby on Rails'
    select 'RR System', from: 'Empresa'
    fill_in 'Descrição da vaga', with: 'Desenvolvimento web com  Ruby on Rails'
    fill_in 'Habilidades necessárias', with: 'Ruby, Rails, TDD, JavaScript,'\
                                                ' HTML, CSS'
    fill_in 'Salário', with: 'À combinar'
    fill_in 'Data de encerramento das inscrições', with: 7.days.from_now
    fill_in 'Nível', with: 'Junior'
    click_on 'Enviar'

    expect(page).to have_content('Desenvolvedor Júnior Ruby on Rails')
    expect(page).to have_content("Data de encerramento das inscrições:\n"\
                                 "#{7.days.from_now.strftime('%d/%m/%Y')}")
    expect(page).to have_content('Vaga publicada com sucesso!')
  end

  scenario 'and must fill all fields' do
    headhunter = create(:headhunter, email: 'headhunter@email.com')

    login_as(headhunter, scope: :headhunter)
    visit opportunities_path
    click_on 'Publicar vaga'

    fill_in 'Título', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Título não pode ficar em branco')
  end
end
