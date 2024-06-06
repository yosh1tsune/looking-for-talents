require 'rails_helper'

feature 'candidate exclude experience', js: true do
  scenario 'successfully' do
    candidate = create(:candidate)
    profile = create(:profile, candidate: candidate)
    experience = create(:experience, profile: profile, company: 'JS Sistemas', role: 'Estagiário - Desenvolvimento Web')
    create(:experience, profile: profile, company: 'RR Sistemas', role: 'Desenvolvimento Backend Jr')

    login_as(candidate)
    visit root_path
    click_on 'Perfil'
    click_on "delete_experience_#{experience.id}"

    expect(page).to have_content 'Experiência excluída com sucesso.'
    expect(page).not_to have_content "Empresa:\nJS Sistemas"
    expect(page).not_to have_content "Cargo:\nEstagiário - Desenvolvimento Web"
    expect(page).to have_content "Empresa:\nRR Sistemas"
    expect(page).to have_content "Cargo:\nDesenvolvimento Backend Jr"
  end
end
