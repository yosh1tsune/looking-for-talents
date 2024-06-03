require 'rails_helper'

feature 'Candidate submit experiences', js: true do
  scenario 'successfully' do
    candidate = create(:candidate)
    create(:profile, candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'
    click_on 'Adicionar Experiência'

    fill_in 'Empresa', with: 'JS Sistemas'
    fill_in 'Cargo', with: 'Estagiário - Desenvolvimento Web'
    fill_in 'Data de Início', with: Date.new(2018, 4, 20)
    fill_in 'Data de Término', with: Date.new(2020, 4, 20)
    fill_in 'Resumo', with: 'Desenvolvimento de Aplicações Web'
    click_on 'Salvar'

    expect(page).to have_content 'Experiência salva com sucesso'
    expect(page).to have_content "Empresa:\nJS Sistemas"
    expect(page).to have_content "Cargo:\nEstagiário - Desenvolvimento Web"
    expect(page).to have_content "Data de Início:\n20/04/2018"
    expect(page).to have_content "Data de Término:\n20/04/2020"
    expect(page).to have_content "Resumo:\nDesenvolvimento de Aplicações Web"
  end

  scenario 'succesffully added a second one' do
    candidate = create(:candidate)
    profile = create(:profile, candidate: candidate)
    create(:experience, profile: profile, company: 'Ruby Apps')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'
    click_on 'Adicionar Experiência'

    fill_in 'Empresa', with: 'JS Sistemas'
    fill_in 'Cargo', with: 'Estagiário - Desenvolvimento Web'
    fill_in 'Data de Início', with: Date.new(2018, 4, 20)
    fill_in 'Data de Término', with: Date.new(2020, 4, 20)
    fill_in 'Resumo', with: 'Desenvolvimento de Aplicações Web'
    click_on 'Salvar'

    expect(page).to have_content 'Experiência salva com sucesso'
    expect(page).to have_content "Empresa:\nRuby Apps"
    expect(page).to have_content "Empresa:\nJS Sistemas"
  end

  scenario 'and must fill all obligatory fields' do
    candidate = create(:candidate)
    create(:profile, candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'
    click_on 'Adicionar Experiência'

    fill_in 'Empresa', with: 'JS Sistemas'
    fill_in 'Resumo', with: 'Desenvolvimento de Aplicações Web'
    click_on 'Salvar'

    expect(page).to have_content 'Corrija os erros!'
    expect(page).to have_content 'Data de Início não pode ficar em branco'
    expect(page).to have_content 'Preencha a data de término do contrato ou '\
                                 'informe que ainda neste emprego.'
  end
end
