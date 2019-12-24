require 'rails_helper'

feature 'candidate visualize opportunities' do
    scenario 'list at index' do
        candidate = Candidate.create(email: 'candidate@email.com', password: 'cand1234')
        opportunity = Opportunity.create(title: 'Desenvolvedor Júnior Ruby on Rails', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista')
        another_opportunity = Opportunity.create(title: 'Analista de Suporte Pleno', work_description: 'Suporte ao usuário interno e externo', 
                            required_abilities: 'Windows, Linux, Bancos de Dados', salary: '2.500,00', grade: 'Pleno', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista')
        third_opportunity = Opportunity.create(title: 'Engenheiro de Software', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista')

        login_as(candidate, scope: candidate)
        visit root_path
        click_on 'Vagas'

        expect(page).to have_content(opportunity.title)
        expect(page).to have_content("#{I18n.t('grade')}: Júnior")
        expect(page).to have_content(another_opportunity.title)
        expect(page).to have_content("#{I18n.t('grade')}: Pleno")
        expect(page).to have_content(third_opportunity.title)
        expect(page).to have_content("#{I18n.t('grade')}: Especialista")
    end

    scenario 'and choose one' do
        candidate = Candidate.create(email: 'candidate@email.com', password: 'cand1234')
        opportunity = Opportunity.create(title: 'Desenvolvedor Júnior Ruby on Rails', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista')

        login_as(candidate)
        visit opportunities_path
        click_on 'Desenvolvedor Júnior Ruby on Rails'

        expect(page).to have_content('Desenvolvedor Júnior Ruby on Rails')
        expect(page).to have_content("#{I18n.t('work_description')}: Desenvolvimento de aplicações web")
        expect(page).to have_content("#{I18n.t('required_abilities')}: Ruby on Rails, TDD, Banco de dados, HTML")
        expect(page).to have_content("#{I18n.t('salary')}: 3.000,00")
        expect(page).to have_content("#{I18n.t('grade')}: Júnior")
        expect(page).to have_content(I18n.l(opportunity.submit_end_date))
        expect(page).to have_link('Inscreva-se')
    end
end