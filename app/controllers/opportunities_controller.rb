class OpportunitiesController < ApplicationController
    before_action :authenticate_candidate!, only: [:register]
    before_action :authenticate_headhunter!, only: [:new, :create]
    before_action :registered?, only: [:show]

    def index
        if headhunter_signed_in?
            headhunter = current_headhunter
            @opportunities = headhunter.opportunities
        else
            @opportunities = Opportunity.all
        end
    end

    def show
        @opportunity = Opportunity.find(params[:id])
        @registrations = @opportunity.candidate_registrations
    end

    def new
        @opportunity = Opportunity.new
    end

    def create
        headhunter = current_headhunter
        @opportunity = headhunter.opportunities.new(opportunity_params)
        
        if @opportunity.save
            flash[:notice] = 'Vaga publicada com sucesso!'
            redirect_to @opportunity
        else
            render :new
        end
    end

    def registered?
        if candidate_signed_in?
            @registered = CandidateRegistration.find_by(candidate_id: current_candidate.id)
        end
    end

    def close
        @opportunity = Opportunity.find(params[:id])
        @opportunity.closed!

        redirect_to @opportunity

        flash[:notice] = 'Inscrições encerradas com sucesso.'
    end

    private

    def opportunity_params
        params.require(:opportunity).permit(:title, :work_description, :required_abilities, :salary, :grade, :submit_end_date, :address, :company)
    end
end