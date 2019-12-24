class OpportunitiesController < ApplicationController
    before_action :authenticate_candidate!, only: [:register]
    # before_action :authenticate_headhunter!, only: [:new, :create]
    before_action :registered?, only: [:show]

    def index
        @opportunities = Opportunity.all
    end

    def show
        @opportunity = Opportunity.find(params[:id])
        ids = @opportunity.registrations.ids
        @candidates = Candidate.where(id: ids)
    end

    def new
        @opportunity = Opportunity.new
    end

    def create
        @opportunity = Opportunity.new(opportunity_params)

        if @opportunity.save
            flash[:notice] = 'Vaga publicada com sucesso!'
            redirect_to @opportunity
        else
            render :new
        end
    end

    def register
        candidate = current_candidate
        @opportunity = Opportunity.find(params[:id])
        @opportunity.registrations.create!(candidate: candidate)

        flash[:notice] = 'Inscrição realizada com sucesso!'
        redirect_to @opportunity
    end

    def registered?
        if candidate_signed_in?
            @registration = Registration.find_by(candidate_id: current_candidate.id)
        end
    end

    private

    def opportunity_params
        params.require(:opportunity).permit(:title, :work_description, :required_abilities, :salary, :grade, :submit_end_date, :address)
    end
end