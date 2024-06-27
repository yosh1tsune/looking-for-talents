module API
  module V1
    class OpportunitiesController < API::V1::APIController
      before_action :authenticate_user!, only: %i[create update destroy]

      def index
        @opportunities = Opportunity.all.page(params[:page]).per(params[:per_page])
        authorize Opportunity
      end

      def show
        @opportunity = Opportunity.find(params[:id])
        authorize Opportunity
      end

      def create
        @opportunity = Opportunities::CreatorService.new(user: @current_user, attributes: opportunity_params).execute
        render status: :created
      rescue ActiveRecord::RecordInvalid => e
        @opportunity = e.record
        render status: :precondition_failed
      end

      def update
        @opportunity = Opportunity.find(params[:id])
        authorize @opportunity
        @opportunity.assign_attributes(opportunity_params)

        if @opportunity.valid?
          @opportunity.update!(opportunity_params)
        else
          render status: :precondition_failed
        end
      end

      def destroy
        @opportunity = Opportunity.find(params[:id])
        authorize @opportunity
        @opportunity.destroy
      end

      private

      def opportunity_params
        params.permit(:title, :work_description, :required_abilities, :grade,
                      :salary, :submit_end_date, :company_id, :headhunter_id)
      end
    end
  end
end
