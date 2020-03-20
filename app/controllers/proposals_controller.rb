class ProposalsController < ApplicationController
  before_action :authenticate_headhunter!, only: %i[create]
  before_action :authenticate_candidate!, only: %i[accept refuse]

  def index
    candidate = current_candidate
    @proposals = candidate.proposals
  end

  def show
    @proposal = Proposal.find(params[:id])
  end

  def create
    @subscription = Subscription.find(params[:subscription_id])
    @proposal = Proposal.new(proposals_params)
    @proposal.opportunity_id = @subscription.opportunity_id
    if @proposal.save
      flash[:notice] = 'Proposta enviada!'
      redirect_to @proposal
    else
      flash[:notice] = 'Proposta não enviada, preencha todos os campos!'
      redirect_to @subscription
    end
  end

  def accept
    @proposal = Proposal.find(params[:id])

    candidate = current_candidate
    proposals = candidate.proposals
    proposals.each(&:refused!)

    @proposal.accepted!

    redirect_to @proposal
  end

  def refuse
    @proposal = Proposal.find(params[:id])

    @proposal.refused!

    redirect_to @proposal
  end

  private

  def proposals_params
    params.require(:proposal).permit(:start_date, :salary, :role, :benefits,
                                     :expectations, :bonuses, :opportunity_id,
                                     :subscription_id)
  end
end
