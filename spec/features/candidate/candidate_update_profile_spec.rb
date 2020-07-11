require 'rails_helper'

feature 'candidate updates profile' do
  scenario 'receive a hint at home page to create his profile', js: true do
    candidate = create(:candidate, email: 'candidate@email.com')

    login_as(candidate, scope: :candidate)
    visit root_path

    expect(page).to have_content 'Seu perfil está incompleto! Acesse a aba '\
                                 'Perfil para preenche-lo!'
  end

  scenario "candidate still don't have profile" do
    candidate = create(:candidate, email: 'candidate@email.com')

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'

    expect(page).to have_content('Complete seu perfil')
    expect(current_path).to eq(new_profile_path)
  end

  scenario 'and create if not', js: true do
    candidate = create(:candidate, email: 'candidate@email.com')

    login_as(candidate)
    visit root_path
    click_on 'Perfil'

    fill_in 'Nome', with: 'Bruno Silva'
    fill_in 'Data de nascimento', with: Date.new(1996, 4, 22)
    fill_in 'CPF', with: '996.490.558-00'
    fill_in 'Escolaridade', with: 'Superior Incompleto'
    fill_in 'Resumo profissional', with: 'Desenvolvimento web com Dart2'
    fill_in 'Logradouro', with: 'Avenida Paulista, 1000'
    fill_in 'Bairro', with: 'Bela Vista'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'País', with: 'Brasil'
    fill_in 'CEP', with: '00000-000'
    attach_file 'Foto', Rails.root.join('spec/support/user.jpg')
    click_on 'Enviar'

    expect(page).to have_content('Perfil atualizado com sucesso')
    expect(page).to have_content('Bruno Silva')
    expect(page).to have_content("Data de nascimento:\n22/04/1996")
    expect(page).to have_content("CPF:\n996.490.558-00")
    expect(page).to have_content("Escolaridade:\nSuperior Incompleto")
    expect(page).to have_content("Resumo profissional:\n"\
                                 'Desenvolvimento web com Dart2')
    expect(page).to have_css("img[src*='user.jpg']")
    expect(page).to have_content("Logradouro:\nAvenida Paulista, 1000")
    expect(page).to have_content("Cidade:\nSão Paulo")
  end

  scenario 'and must fill all fields' do
    candidate = create(:candidate, email: 'candidate@email.com')

    login_as(candidate)
    visit root_path
    click_on 'Perfil'

    fill_in 'Nome', with: 'Bruno Silva'
    fill_in 'Data de nascimento', with: ''
    fill_in 'CPF', with: '996.490.558-00'
    fill_in 'Escolaridade', with: ''
    fill_in 'Resumo profissional', with: 'Desenvolvimento web com Dart2'
    click_on 'Enviar'

    expect(page).to have_content('Data de nascimento não pode ficar em branco')
    expect(page).to have_content('Escolaridade não pode ficar em branco')
    expect(page).to have_content('Foto não pode ficar em branco')
  end

  scenario 'or edit if already have', js: true do
    profile = create(:profile, name: 'Bruno Silva',
                               professional_resume: 'Desenvolvimento web com '\
                                                    'Dart 2')
    create(:address, addressable: profile)

    login_as(profile.candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'
    click_on 'Editar perfil'
    fill_in 'Resumo profissional', with: 'Desenvolvimento web com Dart 2, '\
                                         'Rails, TDD'
    fill_in 'Logradouro', with: 'Avenida Paulista, 1000'
    fill_in 'Bairro', with: 'Bela Vista'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'País', with: 'Brasil'
    fill_in 'CEP', with: '00000-000'
    click_on 'Enviar'

    expect(page).to have_content('Perfil atualizado com sucesso')
    expect(page).to have_content('Bruno Silva')
    expect(page).to have_content("Resumo profissional:\n"\
                                 'Desenvolvimento web com Dart 2, Rails, TDD')
    expect(page).to have_content("Logradouro:\nAvenida Paulista, "\
                                 '1000')
  end

  scenario 'and must fill all fields when editing' do
    candidate = create(:candidate, email: 'candidate@email.com')
    profile = create(:profile, name: 'Bruno Silva', candidate: candidate)

    login_as(candidate, scope: :candidate)
    visit root_path
    click_on 'Perfil'
    click_on 'Editar perfil'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(current_path).to eq profile_path(profile)
    expect(page).to have_content('Nome não pode ficar em branco')
  end
end
