require 'rails_helper'

feature 'visitor visit home index' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('Bem vindo!')
  end
end
