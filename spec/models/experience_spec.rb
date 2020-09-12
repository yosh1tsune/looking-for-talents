require 'rails_helper'

describe Experience do
  describe '.end_date_obligation' do
    it 'successfully' do
      experience = create(:experience, end_date: '28/02/2020',
                                       currently_working: false)

      experience.valid?

      expect(experience.errors).to be_empty
    end

    it 'and must fail if currently_working = false and end_date = nil' do
      experience = build(:experience, end_date: nil, currently_working: false)

      experience.valid?

      expect(experience.errors.full_messages)
        .to eq ['Data de Término Preencha a data de término do contrato ou '\
                'informe que ainda neste emprego.']
    end

    it 'and must set end_date = nil if currently_working = true' do
      experience = build(:experience, end_date: '28/02/2020',
                                      currently_working: true)

      experience.valid?

      expect(experience.errors).to be_empty
      expect(experience.end_date).to eq nil
    end
  end
end
