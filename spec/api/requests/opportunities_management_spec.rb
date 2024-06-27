require 'rails_helper'

describe 'Opportunities Management' do
  let(:headhunter) { create(:headhunter) }
  let(:company) { create(:company) }
  let(:token) do
    JWT.encode(
      {
        id: headhunter.id,
        class: headhunter.class,
        exp: 7.days.from_now.to_i,
        jti: SecureRandom.uuid
      },
      Rails.application.credentials.secret_key_base
    )
  end

  context 'index' do
    it 'succesfully' do
      create(:opportunity, title: 'Desenvolvedor Rails')

      get api_v1_opportunities_path

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:opportunities][0][:title]).to eq 'Desenvolvedor Rails'
    end

    it 'or find nothing' do
      get api_v1_opportunities_path

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:opportunities]).to eq []
    end
  end

  context 'show' do
    it 'successfully' do
      opportunity = create(:opportunity)

      get api_v1_opportunity_path(opportunity)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(body[:id]).to eq opportunity.id
    end

    it "or didn't find a record with the parameter id" do
      get api_v1_opportunity_path(id: 0)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'create' do
    it 'successfully' do
      params = { title: 'Engenheiro de Software',
                 work_description: 'Desenvolvimento de aplicações web',
                 required_abilities: 'Graduação em T.I., Modelagem de '\
                                    'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 company_id: company.id, headhunter_id: headhunter.id }

      post api_v1_opportunities_path, params: params, headers: { 'Authorization': token }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:created)
      expect(body[:title]).to eq 'Engenheiro de Software'
    end

    it 'or fail if incomplete data is submited' do
      post api_v1_opportunities_path, params: {}, headers: { 'Authorization': token }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:precondition_failed)
      expect(body[:message]).to eq [
        'Título não pode ficar em branco',
        'Descrição da vaga não pode ficar em branco',
        'Habilidades necessárias não pode ficar em branco',
        'Salário não pode ficar em branco',
        'Nível não pode ficar em branco',
        'Data de encerramento das inscrições não pode ficar em branco',
        'Company é obrigatório(a)'
      ]
    end

    it 'or raise error 500 if the params are good but the database fails' do
      allow_any_instance_of(Opportunity).to receive(:save!).and_raise(ActiveRecord::ActiveRecordError)

      params = { title: 'Engenheiro de Software',
                 company_id: company.id,
                 work_description: 'Desenvolvimento de aplicações web',
                 required_abilities: 'Graduação em T.I., Modelagem de '\
                                          'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 headhunter_id: headhunter.id }

      post api_v1_opportunities_path, params: params, headers: { 'Authorization': token }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:internal_server_error)
      expect(body[:message]).to eq 'Database Error'
    end

    it 'or raise error 401 if user not logged in' do
      params = { title: 'Engenheiro de Software',
                 company_id: company.id,
                 work_description: 'Desenvolvimento de aplicações web',
                 required_abilities: 'Graduação em T.I., Modelagem de '\
                                          'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 headhunter_id: headhunter.id }

      post api_v1_opportunities_path, params: params

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:unauthorized)
      expect(body[:message]).to eq 'User Not Authorized'
    end

    it 'or raise error 403 if user not allowed to access this resource' do
      candidate = create(:candidate)
      token = JWT.encode(
        {
          id: candidate.id,
          class: candidate.class,
          exp: 7.days.from_now.to_i,
          jti: SecureRandom.uuid
        },
        Rails.application.credentials.secret_key_base
      )

      params = { title: 'Engenheiro de Software',
                 company_id: company.id,
                 work_description: 'Desenvolvimento de aplicações web',
                 required_abilities: 'Graduação em T.I., Modelagem de '\
                                          'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 headhunter_id: headhunter.id }

      post api_v1_opportunities_path, params: params, headers: { 'Authorization': token }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:forbidden)
      expect(response).to have_http_status(:forbidden)
      expect(body[:message]).to eq 'User Not Allowed'
    end
  end

  context 'update' do
    it 'sucessfully' do
      opportunity = create(:opportunity, headhunter: headhunter, title: 'Desenvolvedor Rails')
      company = create(:company, headhunter: headhunter, name: 'Google')

      params = { title: 'Engenheiro de Software',
                 work_description: 'Análise e desenvolvimento de projetos',
                 required_abilities: 'Graduação em T.I., desenvolvimento ágil',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now, company_id: company.id,
                 headhunter_id: opportunity.headhunter_id }

      patch api_v1_opportunity_path(opportunity), params: params, headers: { 'Authorization': token }

      opportunity.reload

      expect(response).to have_http_status(:ok)
      expect(opportunity.title).to eq 'Engenheiro de Software'
      expect(opportunity.company.name).to eq 'Google'
      expect(opportunity.work_description).to eq 'Análise e desenvolvimento '\
                                                 'de projetos'
      expect(opportunity.required_abilities).to eq 'Graduação em T.I., '\
                                                   'desenvolvimento ágil'
      expect(opportunity.salary).to eq '8.000,00'
      expect(opportunity.grade).to eq 'Especialista'
    end

    it 'or fail if not all fields are filled' do
      opportunity = create(:opportunity, headhunter: headhunter, title: 'Desenvolvedor Rails')

      params = { title: 'Engenheiro de Software',
                 work_description: nil,
                 required_abilities: 'Graduação em T.I., Modelagem de'\
                            'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now, company_id: nil,
                 headhunter_id: opportunity.headhunter_id }

      patch api_v1_opportunity_path(opportunity), params: params, headers: { 'Authorization': token }

      expect(response).to have_http_status(:precondition_failed)
    end

    it "or fail if trying to update that doesn't exist" do
      patch api_v1_opportunity_path(id: 0), params: {}, headers: { 'Authorization': token }

      expect(response).to have_http_status(:not_found)
    end

    it 'or raise error 500 if the params are good but the database fails' do
      allow_any_instance_of(Opportunity).to receive(:update!).and_raise(ActiveRecord::ActiveRecordError)

      opportunity = create(:opportunity, headhunter: headhunter, title: 'Desenvolvedor Rails')
      params = { title: 'Engenheiro de Software',
                 company: 'RR Systems',
                 work_description: 'Desenvolvimento de aplicações web',
                 required_abilities: 'Graduação em T.I., Modelagem de'\
                            'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 headhunter_id: opportunity.headhunter_id }

      patch api_v1_opportunity_path(opportunity), params: params, headers: { 'Authorization': token }

      expect(response).to have_http_status(:internal_server_error)
    end
  end

  context 'delete' do
    it 'sucessfully' do
      opportunity = create(:opportunity, headhunter: headhunter, title: 'Desenvolvedor Rails')

      expect do
        delete api_v1_opportunity_path(opportunity), headers: { 'Authorization': token }
      end.to change(Opportunity, :count).from(1).to(0)

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(body[:message]).to eq 'Registro excluído com sucesso.'
    end

    it "or fail if try to delete a object that doesn't exist" do
      delete api_v1_opportunity_path(id: 0), headers: { 'Authorization': token }

      expect(response).to have_http_status(:not_found)
    end
  end
end
