class CandidateRegistrationsController < ApplicationController
before_action :authenticate_candidate!, only: [:index, :create]

    def index
        candidate = current_candidate
        
        @registrations = candidate.candidate_registrations
    end

    def create
        @opportunity = Opportunity.find(params[:opportunity_id])
        candidate = current_candidate

        if @opportunity.open?
            @opportunity.candidate_registrations.create!(candidate: candidate, opportunity: @opportunity, registration_resume: params[:registration_resume])
            flash[:notice] = 'Inscrição realizada com sucesso!'
            redirect_to @opportunity
        else
            flash[:notice] = 'As inscrições para essa vaga foram encerradas!'
            redirect_to @opportunity
        end
    end

    # private

    # def registrations_params
    #     params.require(:registration).permit(:opportunity_id, :registration_resume)
    # end
end