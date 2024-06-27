module API
  module V1
    class APIController < ActionController::API
      attr_reader :current_user

      include Pundit::Authorization

      rescue_from ActiveRecord::ActiveRecordError, with: :database_error
      rescue_from ActiveRecord::RecordNotFound, with: :object_not_found
      rescue_from Pundit::NotAuthorizedError, with: :forbidden

      SECRET_KEY = Rails.application.credentials.secret_key_base

      private

      def object_not_found
        render json: { message: 'Object Not Found' }, status: :not_found
      end

      def database_error
        render json: { message: 'Database Error' }, status: :internal_server_error
      end

      def forbidden
        render json: { message: 'User Not Allowed' }, status: :forbidden
      end

      def unauthorized
        render json: { message: 'User Not Authorized' }, status: :unauthorized
      end

      def authenticate_user!
        raise StandardError if request.headers['Authorization'].blank?

        @jwt_payload = jwt_decode(request.headers['Authorization'])
        @current_user = @jwt_payload['class'].constantize.find(@jwt_payload['id'])
      rescue StandardError
        # unauthorized
      end

      def jwt_encode(payload, expire = 7.days.from_now)
        payload[:exp] = expire.to_i
        payload[:jti] = SecureRandom.uuid
        JWT.encode(payload, SECRET_KEY)
      end

      def jwt_decode(token, key: SECRET_KEY, verify: true, options: {})
        JWT.decode(token, key, verify, options)[0]
      end
    end
  end
end
