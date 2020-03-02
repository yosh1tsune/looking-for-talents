module Api
  module V1
    class ProfilesController < Api::V1::ApiController
      def create
        @profile = Profile.new(profile_params)
        if @profile.valid?
          @profile.save!
          render json: url_for(@profile.avatar), status: :created
        else
          render json: 'Object not created', status: :precondition_failed
        end
      end

      def profile_params
        params.permit(:name, :birth_date, :document, :scholarity,
                      :professional_resume, :candidate_id, :address)
      end
    end
  end
end
