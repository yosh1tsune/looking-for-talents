require 'rails_helper'

describe 'Profiles management' do
  xcontext 'create' do
    it 'successfully' do
      candidate = create(:candidate)

      post api_v1_profiles_path, params: { name: 'Bruno Silva',
                                           birth_date: '22/04/1996',
                                           document: '123.456.789-00',
                                           scholarity: 'Superior Incompleto',
                                           professional_resume: '1 ano estágio',
                                           address: 'Av. Paulista, 5000',
                                           candidate_id: candidate.id }

      expect(response).to have_http_status(:created)
    end
  end
end
