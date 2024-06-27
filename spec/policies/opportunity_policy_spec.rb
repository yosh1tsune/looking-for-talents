require 'rails_helper'

describe OpportunityPolicy do
  let(:headhunter) { create(:headhunter) }
  let(:second_headhunter) { create(:headhunter) }
  let(:opportunity) { create(:opportunity, headhunter: headhunter) }
  let(:second_opportunity) { create(:opportunity, headhunter: second_headhunter) }
  let(:candidate) { create(:candidate) }

  context 'authorization' do
    permissions :index? do
      it 'grant access for anyone' do
        expect(described_class).to permit(nil, Opportunity)
      end
    end

    permissions :show? do
      it 'grant access for users not signed in' do
        expect(described_class).to permit(nil, opportunity)
      end

      it 'and grant access to any opportunity for candidates' do
        expect(described_class).to permit(candidate, opportunity)
        expect(described_class).to permit(candidate, second_opportunity)
      end

      it 'and grant access only to owned opportunities for headhunters' do
        expect(described_class).to permit(headhunter, opportunity)
        expect(described_class).not_to permit(headhunter, second_opportunity)
      end
    end

    permissions :new?, :create? do
      it 'grant access to headhunters' do
        expect(described_class).to permit(headhunter, Opportunity)
      end

      it 'block access to candidates' do
        expect(described_class).not_to permit(candidate, Opportunity)
      end
    end

    permissions :update?, :destroy?, :close? do
      it 'grant access if headhunter IS owner of opportunity' do
        expect(described_class).to permit(headhunter, opportunity)
      end

      it 'block access if headhunter IS NOT owner of opportunity' do
        expect(described_class).not_to permit(second_headhunter, opportunity)
      end
    end
  end

  context 'scope' do
    it 'show everything to users not signed in' do
      expect(Pundit.policy_scope(nil, Opportunity)).to eq Opportunity.all
    end

    it 'and show everything to candidates' do
      expect(Pundit.policy_scope(candidate, Opportunity)).to eq Opportunity.all
    end

    it 'and show only owned opportunities to headhunters' do
      expect(Pundit.policy_scope(headhunter, Opportunity)).to include opportunity
      expect(Pundit.policy_scope(headhunter, Opportunity)).not_to include second_opportunity
    end
  end
end
