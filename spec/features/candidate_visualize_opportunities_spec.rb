require 'rails_helper'

feature 'candidate visualize opportunities' do
    scenario 'list at index' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)
        another_opportunity = Opportunity.create!(title: 'Analista de Suporte Pleno', company: 'RR Systems', work_description: 'Suporte ao usuário interno e externo', 
                            required_abilities: 'Windows, Linux, Bancos de Dados', salary: '2.500,00', grade: 'Pleno', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)
        third_opportunity = Opportunity.create!(title: 'Engenheiro de Software', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                            grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)

        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Vagas'

        expect(page).to have_content(opportunity.title)
        expect(page).to have_content("#{I18n.t('grade')}: #{opportunity.grade}")
        expect(page).to have_content(another_opportunity.title)
        expect(page).to have_content("#{I18n.t('grade')}: #{another_opportunity.grade}")
        expect(page).to have_content(third_opportunity.title)
        expect(page).to have_content("#{I18n.t('grade')}: #{third_opportunity.grade}")
    end

    scenario 'and choose one' do
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista', headhunter: headhunter)

        login_as(candidate, scope: :candidate)
        visit opportunities_path
        click_on 'Desenvolvedor Júnior Ruby on Rails'

        expect(page).to have_content(opportunity.title)
        expect(page).to have_content("#{I18n.t('work_description')}: #{opportunity.work_description}")
        expect(page).to have_content("#{I18n.t('required_abilities')}: #{opportunity.required_abilities}")
        expect(page).to have_content("#{I18n.t('salary')}: #{opportunity.salary}")
        expect(page).to have_content("#{I18n.t('grade')}: #{opportunity.grade}")
        expect(page).to have_content(I18n.l(opportunity.submit_end_date))
        expect(page).to have_button(I18n.t('register'))
    end
end