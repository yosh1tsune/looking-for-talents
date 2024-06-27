require 'rails_helper'

describe ApplicationPolicy do
  context 'authorization' do
    permissions :index?, :show?, :create?, :new?, :update?, :edit?, :destroy? do
      it 'deny access for anyone as default' do
        expect(described_class).not_to permit(nil)
      end
    end
  end

  context 'scope' do
    it 'raise error to force child classes to override resolve method' do
      expect { described_class::Scope.new(nil, nil).resolve }.to raise_error NoMethodError
    end
  end
end
