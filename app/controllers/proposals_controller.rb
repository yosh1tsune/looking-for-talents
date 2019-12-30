class ProposalsController < ApplicationController
    def index
        candidate = current_candidate
        @proposals = candidate.proposals
    end

    def show
        @proposal = Proposal.find(params[:id])
    end

    def create
        @registration = Subscription.find(params[:subscription_id])
        @opportunity = Opportunity.find(params[:opportunity_id])

        @proposal = Proposal.new(proposals_params)
        @proposal.opportunity_id = @opportunity.id
        @proposal.subscription_id = @registration.id

        if @proposal.save
            flash[:notice] = 'Proposta enviada!'
            redirect_to @proposal
        else
            flash[:notice] = 'Proposta não enviada, preencha todos os campos!'
            redirect_to @registration
        end
    end

    def accept
        @proposal = Proposal.find(params[:id])

        proposals = Proposal.all
        proposals.each do |p| 
            p.refused!
        end
        
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
        params.require(:proposal).permit(:start_date, :salary, :role, :benefits, :expectations, :bonuses)
    end
end