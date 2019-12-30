class SubscriptionsController < ApplicationController
before_action :authenticate_candidate!, only: [:index, :create]
before_action :authenticate_headhunter!, only: [:update]

    def index
        candidate = current_candidate
        
        @registrations = candidate.subscriptions
    end

    def show
        @registration = Subscription.find(params[:id])
    end

    def create
        @opportunity = Opportunity.find(params[:opportunity_id])
        candidate = current_candidate

        if @opportunity.open?
            @opportunity.subscriptions.create!(candidate: candidate, opportunity: @opportunity, registration_resume: params[:registration_resume])
            flash[:notice] = 'Inscrição realizada com sucesso!'
            redirect_to @opportunity
        else
            flash[:notice] = 'As inscrições para essa vaga foram encerradas!'
            redirect_to @opportunity
        end
    end

    def update
        @registration = Subscription.find(params[:id])
        if @registration.update(registration_params)
            flash[:notice] = 'Inscrição atualizada com sucesso!'
            redirect_to @registration
        else
            render :show
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