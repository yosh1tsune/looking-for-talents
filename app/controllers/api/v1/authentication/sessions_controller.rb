# API::V1::Authentication::SessionsController
module API
  module V1
    module Authentication
      class SessionsController < API::V1::APIController
        def create
          if resource.valid_password?(sessions_params[:password])
            token = jwt_encode({ id: resource.id, class: resource.class })
            render json: { token: token }, status: :ok
          else
            render json: { message: 'Invalid Password' }, status: :not_found
          end
        end

        private

        def sessions_params
          params.permit(:email, :password, :class)
        end

        def resource
          sessions_params[:class].camelize.constantize.find_by!(email: sessions_params[:email])
        end
      end
    end
  end
end
