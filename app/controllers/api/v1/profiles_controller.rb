class Api::V1::ProfilesController < Api::V1::ApiController
    def create
        @profile = Profile.new(profile_params)
        # byebug
        @profile.avatar.attach(profile_params[:avatar])
        if @profile.valid?
            @profile.save!
            render json: @profile, status: :created
        else
            render json: 'Object not created', status: :precondition_failed
        end
        byebug
    end

    def profile_params
        params.permit(:name, :birth_date, :document, :scholarity, :professional_resume,
                      :candidate_id, :address)
    end
end
