class Api::V1::ProfilesController < Api::V1::ApiController
    def create
        @profile = Profile.new(profile_params)
        @profile.avatar.attach(io: File.open(Rails.root.join('spec/support/user.jpg'), filename: 'user.jpg'))
        if @profile.valid?
            @profile.save!
            render json: url_for(@profile.avatar), status: :created
        else
            render json: 'Object not created', status: :precondition_failed
        end
    end

    def profile_params
        params.permit(:name, :birth_date, :document, :scholarity, :professional_resume,
                      :candidate_id, :address)
    end
end
