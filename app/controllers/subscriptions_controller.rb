class SubscriptionsController < ApplicationController
  before_action :authenticate_candidate!, only: %i[index create]
  before_action :authenticate_headhunter!, only: %i[update highlight]
  before_action :candidate_have_profile?, only: %i[create]

  def index
    candidate = current_candidate

    @subscriptions = candidate.subscriptions
  end

  def show
    @subscription = Subscription.find(params[:id])
    @proposal = Proposal.new
  end

  def create
    @opportunity = Opportunity.find(params[:opportunity_id])
    if @opportunity.open?
      subscription = @opportunity
                     .subscriptions
                     .create!(candidate: current_candidate,
                              registration_resume:
                                params[:subscription][:registration_resume])
      flash[:notice] = 'Inscrição realizada com sucesso!'
      SubscriptionMailer.confirm_subscription(subscription.id)
    else
      flash[:notice] = 'As inscrições para essa vaga foram encerradas!'
    end
    redirect_to @opportunity
  end

  def update
    @subscription = Subscription.find(params[:id])
    @subscription.feedback = subscription_params[:feedback]
    @subscription.status = subscription_params[:status]
    if @subscription.in_progress? || @subscription.feedback.blank?
      flash[:alert] = 'Altere o status da inscrição e preencha o feedback'
      render :show
    else
      @subscription.update(subscription_params)
      flash[:notice] = 'Inscrição atualizada com sucesso!'
      redirect_to @subscription
    end
  end

  def highlight
    @subscription = Subscription.find(params[:id])

    @subscription.toggle(:highlighted).save

    redirect_to @subscription
  end

  private

  def candidate_have_profile?
    profile = Profile.find_by(candidate: current_candidate)
    return if profile.present?

    flash[:alert] = 'Preencha o perfil de canidato antes de se registrar a '\
                    'uma vaga'
    redirect_to new_profile_path
  end

  def subscription_params
    params.require(:subscription).permit(:status, :feedback)
  end
end
