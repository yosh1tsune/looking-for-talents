require 'rails_helper'

describe Chat do
  let(:headhunter) { create(:headhunter) }
  let(:candidate) { create(:candidate) }

  context 'create' do
    it do
      chat = described_class.create(headhunter: headhunter, candidate: candidate)

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
        described_class.create!(candidate: candidate, headhunter: nil)
      end.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Headhunter é obrigatório(a)')
    end

    it 'fail if candidate is not provided' do
      expect do
        described_class.create!(candidate: nil, headhunter: headhunter)
      end.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Candidate é obrigatório(a)')
    end
  end
end
