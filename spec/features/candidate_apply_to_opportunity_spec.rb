require 'rails_helper'

feature 'candidate apply to opportunity' do
    scenario 'successfully' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        opportunity = Opportunity.create!(title: 'Engenheiro de Software', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista')

        login_as(candidate)
        visit root_path
        click_on 'Vagas'
        click_on 'Engenheiro de Software'
        click_on 'Inscreva-se'

        expect(page).to have_content('Inscrição realizada com sucesso!')
        expect(page).not_to have_link('Inscreva-se')
        expect(page).to have_content('Você já está inscrito nesta vaga. Aguarde instruções do recrutador.')
    end
end