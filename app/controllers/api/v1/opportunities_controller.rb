module Api
  module V1
    class OpportunitiesController < Api::V1::ApiController
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
        params.permit(:title, :work_description, :required_abilities, :grade,
                      :salary, :submit_end_date, :company_id, :headhunter_id)
      end
    end
  end
end
