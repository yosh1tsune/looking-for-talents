require 'rails_helper'

describe Chat do
  let(:headhunter) { create(:headhunter) }
  let(:candidate) { create(:candidate) }
  let(:uuid) { SecureRandom.uuid }

  context 'create' do
    it do
      chat = described_class.create(headhunter: headhunter, candidate: candidate, websocket_uuid: uuid)

      expect(chat.headhunter).to eq headhunter
      expect(chat.candidate).to eq candidate
    end

    it 'with factory' do
      chat = create(:chat)

      expect(chat.persisted?).to eq true
      expect(chat.class).to eq Chat
    end
  end

  context 'validations' do
    it 'fail if headhunter is not provided' do
      expect do
        described_class.create!(candidate: candidate, headhunter: nil, websocket_uuid: uuid)
      end.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Headhunter é obrigatório(a)')
    end

    it 'fail if candidate is not provided' do
      expect do
        described_class.create!(candidate: nil, headhunter: headhunter, websocket_uuid: uuid)
      end.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Candidate é obrigatório(a)')
    end

    it 'fail if websocket_uuid is not provided' do
      expect do
        described_class.create!(candidate: candidate, headhunter: headhunter, websocket_uuid: nil)
      end.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Websocket uuid não pode ficar em branco')
    end
  end
end
