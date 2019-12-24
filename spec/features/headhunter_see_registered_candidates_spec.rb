require 'rails_helper'

feature 'headhunter see registered candidates' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        another_candidate = Candidate.create!(email: 'another_candidate@email.com', password: 'head1234')
        third_candidate = Candidate.create!(email: 'third_candidate@email.com', password: 'head1234')
        opportunity = Opportunity.create(title: 'Desenvolvedor Júnior Ruby on Rails', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Beça Vista')
        Registration.create!(opportunity: opportunity, candidate: candidate)
        Registration.create!(opportunity: opportunity, candidate: another_candidate)
        Registration.create!(opportunity: opportunity, candidate: third_candidate)

        login_as(headhunter)
        visit root_path
        click_on 'Vagas'
        click_on 'Desenvolvedor Júnior Ruby on Rails'

        expect(page).to have_content(candidate.email)
        expect(page).to have_content(another_candidate.email)
        expect(page).to have_content(third_candidate.email)
    end

    xscenario 'and visualize their profiles' do
        
    end

    xscenario 'and highlight them' do
        
    end
end