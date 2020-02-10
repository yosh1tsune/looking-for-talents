require 'rails_helper'

describe Proposal do
  describe '.start_date_validator' do
    it 'successfully' do
      proposal = create(:proposal)

      proposal.valid?

      expect(proposal.errors).to be_empty
    end

    it 'unsuccessfully if minor than 14 days' do
      proposal = build(:proposal, start_date: 13.days.from_now)

      proposal.valid?

      expect(proposal.errors.full_messages).to eq(["#{I18n.t('start_date')} "\
        'deve ser ao menos daqui a 14 dias. O candidato precisa se preparar!'])
    end

    it 'unsuccessfully if start_date blank' do
      proposal = build(:proposal, start_date: nil)

      proposal.valid?

      expect(proposal.errors.full_messages).to eq(["#{I18n.t('start_date')} "\
                                                   'não pode ficar em branco'])
    end
  end
end
