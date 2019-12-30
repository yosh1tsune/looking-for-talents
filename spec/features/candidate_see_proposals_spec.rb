require 'rails_helper'

feature 'candidate see proposals' do
    scenario 'successfully' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                            required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                            submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

        proposal = Proposal.create(start_date: 14.days.from_now, salary: 2500, role: 'Desenvolvedor Júnior', expectations: 'Colaborar com as rotinas de testes do time de desenvolvimento',
                                    benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: registration,
                                  opportunity: opportunity)

        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Minhas propostas'

        expect(page).to have_content("Vaga: #{proposal.opportunity.title}")
        expect(page).to have_content("#{I18n.t('role')}: #{proposal.role}")
    end

    scenario 'and choose one' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                                        required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                                        grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        another_opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                                                required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                                                submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
    
        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)
        
        another_registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

        proposal = Proposal.create(start_date: 14.days.from_now, salary: 5000, role: 'Engenheiro de Software', expectations: 'Colaborar com modelagem e documentação do software',
                                    benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: registration,
                                  opportunity: opportunity)

        another_proposal = Proposal.create(start_date: 14.days.from_now, salary: 2500, role: 'Desenvolvedor Júnior', expectations: 'Colaborar com as rotinas de testes do time de desenvolvimento',
                                    benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: another_registration,
                                  opportunity: another_opportunity)

        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Minhas propostas'
        click_on proposal.role
        
        expect(page).to have_content("Vaga: #{proposal.opportunity.title}")
        expect(page).to have_content("#{I18n.t('start_date')}: #{I18n.l(proposal.start_date)}")
        expect(page).to have_content("#{I18n.t('salary')}: #{proposal.salary}")
        expect(page).to have_content("#{I18n.t('role')}: #{proposal.role}")
        expect(page).to have_content("#{I18n.t('benefits')}: #{proposal.benefits}")
        expect(page).to have_content("#{I18n.t('expectations')}: #{proposal.expectations}")
        expect(page).to have_content("#{I18n.t('bonuses')}: #{proposal.bonuses}")
        expect(page).to have_content("#{I18n.t('status')}: #{I18n.t('in_progress')}")
        expect(page).to have_link('Aceitar proposta')
        expect(page).to have_link('Recusar proposta')
    end

    scenario 'and refuse :(' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                                        required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                                        grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        another_opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                                                required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                                                submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
    
        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)
        
        another_registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

        proposal = Proposal.create(start_date: 14.days.from_now, salary: 5000, role: 'Engenheiro de Software', expectations: 'Colaborar com modelagem e documentação do software',
                                    benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: registration,
                                  opportunity: opportunity)

        another_proposal = Proposal.create(start_date: 14.days.from_now, salary: 2500, role: 'Desenvolvedor Júnior', expectations: 'Colaborar com as rotinas de testes do time de desenvolvimento',
                                    benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: another_registration,
                                  opportunity: another_opportunity)

        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Minhas propostas'
        click_on proposal.role
        click_on 'Recusar proposta'
        
        expect(page).to have_content("Vaga: #{proposal.opportunity.title}")
        expect(page).to have_content("#{I18n.t('start_date')}: #{I18n.l(proposal.start_date)}")
        expect(page).to have_content("#{I18n.t('salary')}: #{proposal.salary}")
        expect(page).to have_content("#{I18n.t('role')}: #{proposal.role}")
        expect(page).to have_content("#{I18n.t('benefits')}: #{proposal.benefits}")
        expect(page).to have_content("#{I18n.t('expectations')}: #{proposal.expectations}")
        expect(page).to have_content("#{I18n.t('bonuses')}: #{proposal.bonuses}")
        expect(page).to have_content("#{I18n.t('status')}: #{I18n.t('refused')}")
        expect(page).not_to have_link('Aceitar proposta')
        expect(page).not_to have_link('Recusar proposta')
    end

    scenario 'OR ACCEPT :D' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                                        required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                                        grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        another_opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                                                required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                                                submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
    
        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)
        
        another_registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

        proposal = Proposal.create(start_date: 14.days.from_now, salary: 5000, role: 'Engenheiro de Software', expectations: 'Colaborar com modelagem e documentação do software',
                                    benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: registration,
                                  opportunity: opportunity)

        another_proposal = Proposal.create(start_date: 14.days.from_now, salary: 2500, role: 'Desenvolvedor Júnior', expectations: 'Colaborar com as rotinas de testes do time de desenvolvimento',
                                    benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: another_registration,
                                  opportunity: another_opportunity)

        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Minhas propostas'
        click_on proposal.role
        click_on 'Aceitar proposta'
        
        expect(page).to have_content("Vaga: #{proposal.opportunity.title}")
        expect(page).to have_content("#{I18n.t('start_date')}: #{I18n.l(proposal.start_date)}")
        expect(page).to have_content("#{I18n.t('salary')}: #{proposal.salary}")
        expect(page).to have_content("#{I18n.t('role')}: #{proposal.role}")
        expect(page).to have_content("#{I18n.t('benefits')}: #{proposal.benefits}")
        expect(page).to have_content("#{I18n.t('expectations')}: #{proposal.expectations}")
        expect(page).to have_content("#{I18n.t('bonuses')}: #{proposal.bonuses}")
        expect(page).to have_content("#{I18n.t('status')}: #{I18n.t('accepted')}")
        expect(page).not_to have_link('Aceitar proposta')
        expect(page).not_to have_link('Recusar proposta')
    end

    scenario 'and check if the other are refused' do
        headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
        candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
        profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                
        opportunity = Opportunity.create!(title: 'Engenheiro de Software', company: 'RR System', work_description: 'Desenvolvimento de aplicações web', 
                                        required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis', salary: '8.000,00', 
                                        grade: 'Especialista', submit_end_date: 14.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)

        another_opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                                                required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                                                submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
    
        registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)
        
        another_registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

        proposal = Proposal.create(start_date: 14.days.from_now, salary: 5000, role: 'Engenheiro de Software', expectations: 'Colaborar com modelagem e documentação do software',
                                    benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: registration,
                                  opportunity: opportunity)

        another_proposal = Proposal.create(start_date: 14.days.from_now, salary: 2500, role: 'Desenvolvedor Júnior', expectations: 'Colaborar com as rotinas de testes do time de desenvolvimento',
                                    benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: registration,
                                  opportunity: another_opportunity)

        login_as(candidate, scope: :candidate)
        visit root_path
        click_on 'Minhas propostas'
        click_on proposal.role
        click_on 'Aceitar proposta'
        visit proposals_path

        expect(page).to have_content("Vaga: #{proposal.opportunity.title}")
        expect(page).to have_content("#{I18n.t('role')}: #{proposal.role}")
        expect(page).to have_content("#{I18n.t('status')}: Aceita")
        expect(page).to have_content("Vaga: #{another_proposal.opportunity.title}")
        expect(page).to have_content("#{I18n.t('role')}: #{another_proposal.role}")
        expect(page).to have_content("#{I18n.t('status')}: Recusada")
    end
end