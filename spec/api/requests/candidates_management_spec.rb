require 'rails_helper'

describe 'Candidates management' do
  context 'create' do
    it 'successfully' do
      post api_v1_candidates_path, params: { candidate: { email: 'candidate@email.com', password: 'Cand123' } }

      body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:created)
      expect(body[:id]).not_to eq nil
      expect(body[:email]).to eq 'candidate@email.com'
      expect(body[:message]).to eq I18n.t('devise.confirmations.send_instructions')
    end
  end
end
