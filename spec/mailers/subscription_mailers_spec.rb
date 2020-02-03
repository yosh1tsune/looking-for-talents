require 'rails_helper'

RSpec.describe do
  describe '#confirm_registration' do
    it 'should create a email' do
      candidate = create(:candidate, email: 'brunorsilva_@hotmail.com')
      profile = create(:profile, candidate: candidate)
      opportunity = create(:opportunity, title: 'Desenvolvedor Ruby on Rails')
      subscription = create(:subscription, candidate: candidate, opportunity: opportunity)

      email = SubscriptionMailer.confirm_subscription(subscription.id)

      expect(email.to).to include(candidate.email)
      expect(email.from).to include 'no-reply@lookingfortalents.com.br'
      expect(email.subject).to eq 'Confirmação de registro em vaga'
      expect(email.body).to include "Olá #{candidate.profile.name}"
      expect(email.body).to include "Seu registro na vaga #{opportunity.title} foi concluido com sucesso!"
    end
  end
end
