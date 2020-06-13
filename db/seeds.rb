headhunter_a = Headhunter.create(email: 'first_headhunter@email.com',
                                 password: 'head1234',
                                 name: 'Bruno', surname: 'Silva')

headhunter_b = Headhunter.create(email: 'second_headhunter@email.com',
                                 password: 'head5678',
                                 name: 'Rocky', surname: 'Balboa')

company_a = Company.create(name: 'RR Systems', document: '46.318.224/0001-47',
                           description: 'Soluções em aplicações web baseadas '\
                                        'em Ruby on Rails',
                                        email: 'rrsystem@lookingfortalents.com',
                                        phone: '(11) 0000-0000', headhunter: headhunter_a)

Address.create(street: 'Avenida Paulista, 9000', neighborhood: 'Bela Vista',
               city: 'São Paulo', state: 'SP', country: 'Brasil',
               zipcode: '00000-000', addressable: company_a)
                                        
company_b = Company.create(name: 'FinDevs', document: '31.516.545/0001-89',
                           description: 'Aplicações financeiras',
                           email: 'findevs@lookingfortalents.com',
                           phone: '(11) 0000-0000', headhunter: headhunter_b)
Address.create(street: 'Avenida Rebouças, 5000', neighborhood: 'Pinheiros',
               city: 'São Paulo', state: 'SP', country: 'Brasil',
               zipcode: '00000-000', addressable: company_b)
              
company_c = Company.create(name: 'SF Devs', document: '92.015.880/0001-98',
                           description: 'Desenvolvimento de softwares Java',
                           email: 'sfdevs@lookingfortalents.com',
                           phone: '(11) 0000-0000', headhunter: headhunter_b)

Address.create(street: 'Avenida Tiradentes, 1100', neighborhood: 'Bom Retiro',
              city: 'São Paulo', state: 'SP', country: 'Brasil',
              zipcode: '00000-000', addressable: company_c)

ServicingHeadhunter.create(company: company_a, headhunter: headhunter_a)

ServicingHeadhunter.create(company: company_b, headhunter: headhunter_b)

ServicingHeadhunter.create(company: company_c, headhunter: headhunter_b)

candidate_a = Candidate.create(email: 'first_candidate@email.com',
                               password: 'cand1234')

profile_a = Profile.create(name: 'Bruno Silva', birth_date: '22/04/1996',
               document: '467.642.068-48', scholarity: 'Superior Incompleto',
               professional_resume: 'Estágio em Desenvolvimento Web e '\
                                    'Suporte ao Usuário',
               candidate: candidate_a)
              
Address.create(street: 'Avenida Edgar Facó, 100', neighborhood: 'Pirituba',
              city: 'São Paulo', state: 'SP', country: 'Brasil',
              zipcode: '00000-000', addressable: profile_a)

Candidate.create(email: 'second_candidate@email.com', password: 'cand5678')

opportunity_a = Opportunity.create(title: 'Desenvolvedor Júnior Ruby on Rails',
                                   grade: 'Júnior', salary: 3_500,
                                   work_description: 'Desenvolver aplicações',
                                   required_abilities: 'Ruby on Rails, '\
                                   'conhecimento de TDD metodologias ágeis, '\
                                   'bancos de dados',
                                   company: company_a,
                                   submit_end_date: '29/06/3020',
                                   headhunter: headhunter_a)

opportunity_b = Opportunity.create(title: 'Desenvolvedor Pleno Ruby on Rails',
                                   grade: 'Pleno', salary: 12_000,
                                   work_description: 'Coordenar a equipe de '\
                                                     'desenvolvimento',
                                   required_abilities: 'Ruby on Rails, '\
                                   'conhecimento de TDD, metodologias ágeis, '\
                                   'bancos de dados, 5 anos de experiência',
                                   company: company_a,
                                   submit_end_date: '29/06/3020',
                                   headhunter: headhunter_a)

Opportunity.create(title: 'Desenvolvedor Front-End', grade: 'Senior',
                   work_description: 'Desenvolver interfaces de aplicações, '\
                                     'lançamentos de hotsites e landing pages',
                   required_abilities: 'React, Node, Adobe DW e PS, '\
                                        'metodologias ágeis',
                   salary: 7_500, company: company_a,
                   submit_end_date: '29/06/3020', headhunter: headhunter_a)

Opportunity.create(title: 'Analista de Suporte', grade: 'Senior',
                   work_description: 'Auxiliar usuários internos e externos, '\
                                     'relatar possíveis bugs e falhas ao time '\
                                     'de desenvolvimento',
                   required_abilities: 'React, Node, Adobe DW e PS, '\
                                       'metodologias ágeis',
                   salary: 5_000, company: company_a, 
                   submit_end_date: '29/06/3020', headhunter: headhunter_a)

Opportunity.create(title: 'Engenheiro de Software', grade: 'Pleno',
                   work_description: 'Coordenar projetos e equipes, resolver '\
                                     'problemas, implementar métodos ágeis',
                   required_abilities: 'Programação OO, SOLID, TDD, React, '\
                                       'Ruby, Node, metodologias ágeis',
                   salary: 7_500, company: company_a,
                   submit_end_date: '29/06/3020', headhunter: headhunter_a)

Opportunity.create(title: 'Desenvolvedor Java', grade: 'Senior',
                   work_description: 'Desenvolver aplicações financeiras',
                   required_abilities: 'Java, Banco de Dados ORACLE, TDD '\
                                       'Design Patterns',
                   salary: 7_500, company: company_b,
                   submit_end_date: '29/06/3020', headhunter: headhunter_b)

Opportunity.create(title: 'Desenvolvedor Back-End', grade: 'Pleno',
                   work_description: 'Desenvolvimento em Java com Spring, '\
                                     'Framework, resolução de problemas, '\
                                     'criação de portais/websites',
                   required_abilities: 'JPA, SQL Server, arquitetura e, '\
                                       'microsserviços',
                   salary: 7_500, company: company_c,
                   submit_end_date: '04/10/3020', headhunter: headhunter_b)

opportunity_c = Opportunity.create(title: 'Desenvolvedor Full-Stack',
                                   grade: 'Júnior',
                                   work_description: 'Manutenção e '\
                                   'desenvolvimento de plataformas web',
                                   required_abilities: 'React, Spring',
                                   salary: 4_500, company: company_c,
                                   submit_end_date: '29/08/3020',
                                   headhunter: headhunter_b)

subscription_a = Subscription.create(candidate: candidate_a,
                                     opportunity: opportunity_a,
                                     registration_resume: 'Graduando em ADS, '\
                                     'estágio em desenvolvimento com Dart 2, '\
                                      'TreinaDev 2 Campus Code',
                                     highlighted: true, status: :approved,
                                     feedback: 'Gostamos do seu perfil! '\
                                     'Vamos conversar mais')

subscription_b = Subscription.create(candidate: candidate_a,
                                     opportunity: opportunity_c,
                                     registration_resume: 'Graduando em ADS, '\
                                     'estágio em desenvolvimento com Dart 2, '\
                                     'TreinaDev 2 Campus Code',
                                     highlighted: true, status: :approved,
                                     feedback: 'Seu perfil nos chamou a '\
                                     'atenção! Entraremos em contato em breve')

Subscription.create(candidate: candidate_a, opportunity: opportunity_b,
                    registration_resume: 'Graduando em ADS, estágio em '\
                                         'desenvolvimento com Dart 2, '\
                                         'TreinaDev 2 Campus Code',
                    status: :refused,
                    feedback: 'Você está indo bem mas precisamos de alguém '\
                              'mais experiente')

Proposal.create(start_date: '19/07/3020', salary: 3_500,
                benefits: 'VR, VA, Convênio Médico',
                role: 'Desenvolvedor Ruby Júnior',
                expectations: 'Se encaixar bem na equipe e contribuir '\
                              'positivamente para o andamento do projeto',
                bonuses: 'Participação de Lucros',
                opportunity: opportunity_a,
                subscription: subscription_a)

Proposal.create(start_date: '19/07/3020', salary: 4_500,
                benefits: 'VR, VA, Convênio Médico',
                role: 'Desenvolvedor Full-Stack Júnior',
                expectations: 'Desenvolver aplicações totalmente funcionais a '\
                              'médio prazo',
                bonuses: 'Participação de Lucros',
                opportunity: opportunity_c,
                subscription: subscription_b)
