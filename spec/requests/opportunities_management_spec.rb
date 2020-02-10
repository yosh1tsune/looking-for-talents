require 'rails_helper'

describe 'Opportunities Management' do
  context 'index' do
    it 'succesfully' do
      opportunities = create(:opportunity, title: 'Desenvolvedor Rails')

      get api_v1_opportunities_path(opportunities)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[0][:title]).to eq 'Desenvolvedor Rails'
    end

    it 'or find nothing' do
      get api_v1_opportunities_path

      expect(response).to have_http_status(:not_found)
      expect(response.body).to eq 'No records found'
    end
  end

  context 'show' do
    it 'successfully' do
      opportunity = create(:opportunity)

      get api_v1_opportunity_path(opportunity)

      expect(response).to have_http_status(:ok)
    end

    it "or didn't find a record with the parameter id" do
      get api_v1_opportunity_path(id: 999)

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'create' do
    it 'successfully' do
      headhunter = create(:headhunter)

      params = { title: 'Engenheiro de Software',
                 company: 'RR Systems',
                 work_description: 'Desenvolvimento de aplicações web',
                 required_abilities: 'Graduação em T.I., Modelagem de'\
                                    'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 address: 'Avenida Paulista, 1000 - Bela Vista',
                 headhunter_id: headhunter.id }

      post api_v1_opportunities_path, params: params

      expect(response).to have_http_status(:created)
    end

    it 'or fail if incomplete data is submited' do
      post api_v1_opportunities_path, params: {}

      expect(response).to have_http_status(:precondition_failed)
    end

    it 'or raise error 500 if the params are good but the database fails' do
      headhunter = create(:headhunter)

      allow_any_instance_of(Opportunity).to receive(:save!)
        .and_raise(ActiveRecord::ActiveRecordError)
      params = { title: 'Engenheiro de Software',
                 company: 'RR Systems',
                 work_description: 'Desenvolvimento de aplicações web',
                 required_abilities: 'Graduação em T.I., Modelagem de'\
                                          'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 address: 'Avenida Paulista, 1000 - Bela Vista',
                 headhunter_id: headhunter.id }

      post api_v1_opportunities_path, params: params

      expect(response).to have_http_status(:internal_server_error)
    end
  end

  context 'update' do
    it 'sucessfully' do
      opportunity = create(:opportunity, title: 'Desenvolvedor Rails')

      params = { title: 'Engenheiro de Software',
                 company: 'Google',
                 work_description: 'Análise e desenvolvimento de projetos',
                 required_abilities: 'Graduação em T.I., desenvolvimento ágil',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 address: 'Alameda Santos, 1239',
                 headhunter_id: opportunity.headhunter_id }

      patch api_v1_opportunity_path(opportunity), params: params

      opportunity.reload

      expect(response).to have_http_status(:ok)
      expect(opportunity.title).to eq 'Engenheiro de Software'
      expect(opportunity.company).to eq 'Google'
      expect(opportunity.work_description).to eq 'Análise e desenvolvimento '\
                                                 'de projetos'
      expect(opportunity.required_abilities).to eq 'Graduação em T.I., '\
                                                   'desenvolvimento ágil'
      expect(opportunity.salary).to eq '8.000,00'
      expect(opportunity.grade).to eq 'Especialista'
      expect(opportunity.address).to eq 'Alameda Santos, 1239'
    end

    it 'or fail if not all fields are filled' do
      opportunity = create(:opportunity, title: 'Desenvolvedor Rails')

      params = { title: 'Engenheiro de Software',
                 company: nil,
                 work_description: nil,
                 required_abilities: 'Graduação em T.I., Modelagem de'\
                            'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 address: 'Avenida Paulista, 1000 - Bela Vista',
                 headhunter_id: opportunity.headhunter_id }

      patch api_v1_opportunity_path(opportunity), params: params

      expect(response).to have_http_status(:precondition_failed)
    end

    it "or fail if trying to update that doesn't exist" do
      patch api_v1_opportunity_path(id: 999), params: {}

      expect(response).to have_http_status(:not_found)
    end

    it 'or raise error 500 if the params are good but the database fails' do
      opportunity = create(:opportunity, title: 'Desenvolvedor Rails')

      params = { title: 'Engenheiro de Software',
                 company: 'RR Systems',
                 work_description: 'Desenvolvimento de aplicações web',
                 required_abilities: 'Graduação em T.I., Modelagem de'\
                            'Banco de dados, Metodologias Ágeis',
                 salary: '8.000,00', grade: 'Especialista',
                 submit_end_date: 14.days.from_now,
                 address: 'Avenida Paulista, 1000 - Bela Vista',
                 headhunter_id: opportunity.headhunter_id }

      allow_any_instance_of(Opportunity).to receive(:update!)
        .and_raise(ActiveRecord::ActiveRecordError)

      patch api_v1_opportunity_path(opportunity), params: params

      expect(response).to have_http_status(:internal_server_error)
    end
  end

  context 'delete' do
    it 'sucessfully' do
      opportunity = create(:opportunity, title: 'Desenvolvedor Rails')

      expect do
        delete api_v1_opportunity_path(opportunity)
      end.to change(Opportunity, :count).from(1).to(0)

      expect(response).to have_http_status(:ok)
    end

    it "or fail if try to delete a object that doesn't exist" do
      delete api_v1_opportunity_path(id: 999)

      expect(response).to have_http_status(:not_found)
    end
  end
end
