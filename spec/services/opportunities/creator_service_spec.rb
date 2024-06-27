require 'rails_helper'

describe Opportunities::CreatorService do
  RSpec::Matchers.define_negated_matcher :not_change, :change

  let(:headhunter) { create(:headhunter) }
  let(:company) { create(:company, headhunter: headhunter) }
  let(:candidate) { build(:candidate) }
  let(:attributes) do
    {
      title: 'Engenheiro de Software',
      company_id: company.id,
      work_description: 'Desenvolvimento de aplicações web',
      required_abilities: 'Graduação em T.I., Modelagem de Banco de dados, Metodologias Ágeis',
      salary: '8.000,00', grade: 'Especialista',
      submit_end_date: 14.days.from_now
    }
  end

  context 'execute' do
    context 'successfully' do
      it 'create opportunity' do
        expect do
          opportunity = described_class.new(user: headhunter, attributes: attributes).execute

          expect(opportunity.title).to eq 'Engenheiro de Software'
          expect(opportunity.headhunter).to eq headhunter
        end.to change { Opportunity.count }.from(0).to(1)
      end
    end

    context 'fail' do
      it 'raise Pundit::NotAuthorizedError if user is not a headhunter' do
        expect do
          described_class.new(user: candidate, attributes: nil).execute
        end.to raise_error(Pundit::NotAuthorizedError).and(not_change { Opportunity.count })
      end

      it 'if attributes are missing' do
        expect do
          described_class.new(user: headhunter, attributes: nil).execute
        end.to raise_error(ActiveRecord::RecordInvalid).and(not_change { Opportunity.count })
      end
    end
  end
end
