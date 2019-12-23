require 'rails_helper'

feature 'candidate updates profile' do
    scenario "candidate still don't have profile" do
        candidate = Candidate.create(email: 'candidate@email.com', password: 'cand1234')

        login_as(candidate)
        visit root_path
        click_on 'Perfil'

        expect(page).to have_content('Complete seu perfil')
    end
end