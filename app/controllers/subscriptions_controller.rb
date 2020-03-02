class SubscriptionsController < ApplicationController
  before_action :authenticate_candidate!, only: %i[index create]
  before_action :authenticate_headhunter!, only: %i[update highlight]

  def index
    candidate = current_candidate

    @registrations = candidate.subscriptions
  end

  def show
    @registration = Subscription.find(params[:id])
    @proposal = Proposal.new
  end

  def create
    @opportunity = Opportunity.find(params[:opportunity_id])
    candidate = current_candidate
    if @opportunity.open?
      subscription = @opportunity.subscriptions
                                 .create!(candidate: candidate,
                                          opportunity: @opportunity,
                                          registration_resume: params[:registration_resume])
      flash[:notice] = 'Inscrição realizada com sucesso!'
      SubscriptionMailer.confirm_subscription(subscription.id)
    else
      flash[:notice] = 'As inscrições para essa vaga foram encerradas!'
    end
    redirect_to @opportunity
  end

  def update
    @registration = Subscription.find(params[:id])
    @registration.assign_attributes(registration_params)
    if @registration.in_progress? || @registration.feedback.blank?
      flash[:alert] = 'Altere o status da inscrição e preencha o feedback'
      render :show
    else
      @registration.update(registration_params)
      flash[:notice] = 'Inscrição atualizada com sucesso!'
      redirect_to @registration
    end
  end

  def highlight
    @registrations = Subscription.find(params[:id])

    @registrations.toggle(:highlighted).save

    redirect_to @registrations
  end

  private

  def registration_params
    params.require(:subscription).permit(:status, :feedback)
  end
end
