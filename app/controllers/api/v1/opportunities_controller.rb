class Api::V1::OpportunitiesController < Api::V1::ApiController
    def index
        @opportunities = Opportunity.all

        if @opportunities.blank?
            render json: 'No records found', status: :not_found
        else
            render json: @opportunities
        end
    end

    def show
        @opportunity = Opportunity.find(params[:id])

        render json: @opportunity
    end

    def create
        @opportunity = Opportunity.new(opportunity_params)
    
        if @opportunity.valid?
            @opportunity.save!
            render json: @opportunity, status: :created
        else
            render json: 'Opportunity not submited', status: :precondition_failed
        end
    end

    def update
        @opportunity = Opportunity.find(params[:id])
        @opportunity.assign_attributes(opportunity_params)

        if @opportunity.valid?
            @opportunity.update!(opportunity_params)
            render json: @opportunity, status: :ok
        else
            render json: 'Object not updated', status: :precondition_failed
        end
    end
    
    def destroy
        @opportunity = Opportunity.find(params[:id])

        @opportunity.destroy

        render json: 'Object deleted', status: :ok
    end

    private

    def opportunity_params
        {title: params[:title], company: params[:company], work_description: params[:work_description],
        required_abilities: params[:required_abilities], salary: params[:salary], grade: params[:grade], 
        submit_end_date: params[:submit_end_date], address: params[:address], headhunter_id: params[:headhunter_id]}
    end
end