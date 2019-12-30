require 'rails_helper'

describe Proposal do
    describe '.start_date_validator' do
        it 'successfully' do
          headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
          candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
          profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                  professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                  
          opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                              required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                              submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
  
          registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

          proposal = Proposal.create(start_date: 14.days.from_now, salary: 2500, role: 'Dsenvolvedor Júnior', expectations: 'Colaborar com as rotinas de testes do time de desenvolvimento',
                                      benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: registration,
                                    opportunity: opportunity)
          
          proposal.valid?

          expect(proposal.errors).to be_empty
        end

        it 'unsuccessfully if minor than 14 days' do
          headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
          candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
          profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                  professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                  
          opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                              required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                              submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
  
          registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

          proposal = Proposal.create(start_date: 13.days.from_now, salary: 2500, role: 'Dsenvolvedor Júnior', expectations: 'Colaborar com as rotinas de testes do time de desenvolvimento',
                                      benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: registration,
                                    opportunity: opportunity)

          proposal.valid?
          
          expect(proposal.errors.full_messages).to eq(["#{I18n.t('start_date')} deve ser ao menos daqui a 14 dias. O candidato precisa se preparar!"])
        end

        it 'unsuccessfully if start_date blank' do
          headhunter = Headhunter.create!(email: 'headhunter@email.com', password: 'head1234')
          candidate = Candidate.create!(email: 'candidate@email.com', password: 'cand1234')
          profile = Profile.create!(name: 'Bruno Silva', birth_date: '22/04/1996', document: '996.490.558-00', scholarity: 'Superior Incompleto', 
                                  professional_resume: 'Desenvolvimento web com Dart 2', address: 'Alameda Santos, 1293', candidate: candidate)
                                  
          opportunity = Opportunity.create!(title: 'Desenvolvedor Júnior Ruby on Rails', company: 'RR Systems', work_description: 'Desenvolvimento de aplicações web', 
                              required_abilities: 'Ruby on Rails, TDD, Banco de dados, HTML', salary: '3.000,00', grade: 'Júnior', 
                              submit_end_date: 7.days.from_now, address: 'Avenida Paulista, 1000 - Bela Vista', headhunter: headhunter)
  
          registration = Subscription.create!(opportunity: opportunity, candidate: candidate, registration_resume: '1 ano de estágio com desenvolvimento web', status: :approved)

          proposal = Proposal.create(salary: 2500, role: 'Dsenvolvedor Júnior', expectations: 'Colaborar com as rotinas de testes do time de desenvolvimento',
                                      benefits: 'Vale Transporte, Vale Refeição, Convênio Médico', bonuses: 'Participação de lucros', subscription: registration,
                                    opportunity: opportunity)
            
          proposal.valid?

          expect(proposal.errors.full_messages).to eq(["#{I18n.t('start_date')} não pode ficar em branco"])
        end
    end
end
