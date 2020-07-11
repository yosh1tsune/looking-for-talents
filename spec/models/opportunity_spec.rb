require 'rails_helper'

describe Opportunity do
  describe '.date_validator' do
    it 'successfully' do
      opportunity = create(:opportunity, title: 'Engenheiro de Software')

      opportunity.valid?

      expect(opportunity.errors).to be_empty
    end

    it 'unsuccessfully if minor than 7 days' do
      opportunity = build(:opportunity, title: 'Engenheiro de Software',
                                        submit_end_date: 6.days.from_now)

      opportunity.valid?

      expect(opportunity.errors.full_messages).to eq(
        ['Data de encerramento das inscrições deve ser ao menos daqui a 7 dias']
      )
    end

    it 'unsuccessfully if submit_end_date blank' do
      opportunity = build(:opportunity, title: 'Engenheiro de Software',
                                        submit_end_date: nil)

      opportunity.valid?

      expect(opportunity.errors.full_messages).to eq(
        ['Data de encerramento das inscrições não pode ficar em branco']
      )
    end
  end
end
