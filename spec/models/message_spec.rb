require 'rails_helper'

describe Message do
  let(:headhunter) { create(:headhunter) }
  let(:candidate) { create(:candidate) }
  let(:chat) { create(:chat, headhunter: headhunter, candidate: candidate) }

  context 'create' do
    it do
      from_headhunter = chat.messages.create(from: headhunter, to: candidate, text: 'Hello!')
      from_candidate = chat.messages.create(from: candidate, to: headhunter, text: 'Hello!!!')

      expect(chat.messages).to include from_headhunter
      expect(chat.messages).to include from_candidate
    end

    it 'with factory' do
      message = create(:message)

      expect(message.persisted?).to eq true
      expect(message.class).to eq Message
    end
  end

  context 'validations' do
    it 'fail if chat is not provided' do
      expect do
        described_class.create!(from: candidate, to: headhunter, text: 'Hello!!!')
      end.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Chat é obrigatório(a)')
    end

    it 'fail if from is not provided' do
      expect do
        chat.messages.create!(from: nil, to: headhunter, text: 'Hello!!!')
      end.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: From é obrigatório(a)')
    end

    it 'fail if to is not provided' do
      expect do
        chat.messages.create!(from: headhunter, to: nil, text: 'Hello!!!')
      end.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: To é obrigatório(a)')
    end

    it 'fail if text is not provided' do
      expect do
        chat.messages.create!(from: headhunter, to: candidate, text: nil)
      end.to raise_error(ActiveRecord::RecordInvalid, 'A validação falhou: Text não pode ficar em branco')
    end
  end
end
