class SubscriptionMailer < ApplicationMailer
  def confirm_subscription(subscription_id)
    @subscription = Subscription.find(subscription_id)

    mail(to: @subscription.candidate.email,
         subject: 'Confirmação de registro em vaga')
  end
end
