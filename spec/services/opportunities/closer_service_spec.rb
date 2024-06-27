require 'rails_helper'

describe Opportunities::CloserService do
  RSpec::Matchers.define_negated_matcher :not_change, :change

  let(:headhunter) { build(:headhunter) }
  let(:second_headhunter) { build(:headhunter) }
  let(:opportunity) { create(:opportunity, headhunter: headhunter) }

  context 'execute' do
    it 'close opportunity' do
      expect do
        described_class.new(user: headhunter, opportunity_id: opportunity.id).execute
      end.to change { opportunity.reload.status }.from('open').to('closed')
    end

    it 'raise Pundit::NotAuthorizedError' do
      expect do
        described_class.new(user: second_headhunter, opportunity_id: opportunity.id).execute
      end.to raise_error(Pundit::NotAuthorizedError).and(not_change { opportunity.reload.status })
    end
  end
end
