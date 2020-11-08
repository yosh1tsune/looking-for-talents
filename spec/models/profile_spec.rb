require 'rails_helper'

describe Profile do
  describe '.validate cpf' do
    it 'is valid' do
      candidate = create(:candidate)
      profile = build(:profile, candidate: candidate,
                                document: '911.563.480-99')

      profile.valid?

      expect(profile.errors).to be_empty
    end

    it 'is invalid if fails in the mod 11 verification' do
      candidate = create(:candidate)
      profile = build(:profile, candidate: candidate,
                                document: '111.222.333-55')

      profile.valid?

      expect(profile.errors.full_messages).to eq ['CPF inválido. Verifique se '\
                                                  'inseriu corretamente']
    end

    it 'is invalid if nil' do
      candidate = create(:candidate)
      profile = build(:profile, candidate: candidate,
                                document: '')

      profile.valid?

      expect(profile.errors.full_messages).to eq ['CPF não pode ficar em '\
                                                  'branco']
    end
  end
end
