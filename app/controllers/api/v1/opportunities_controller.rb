module Api
  module V1
    class OpportunitiesController < Api::V1::ApiController
      # before_action :authenticate_user!, only: %i[create update destroy]

      def index
        @opportunities = Opportunity.all.page(params[:page]).per(params[:per_page])
      end

      def show
        @opportunity = Opportunity.find(params[:id])
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
