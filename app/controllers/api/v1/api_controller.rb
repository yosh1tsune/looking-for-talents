module Api
  module V1
    class ApiController < ActionController::API
      rescue_from ActiveRecord::ActiveRecordError, with: :database_error
      rescue_from ActiveRecord::RecordNotFound, with: :object_not_found

      SECRET_KEY = Rails.application.secret_key_base

      def object_not_found
        render json: { message: 'Object Not Found' }, status: :not_found
      end

      def database_error
        render json: { message: 'Database Error' },
               status: :internal_server_error
      end

      def authenticate_user!
        procces_token

        return if @current_user.present?

        render json: { message: 'User Not Logged In' },
               status: :unauthorized
      end

      def procces_token
        return if request.headers['Authorization'].blank?

        @jwt_payload = jwt_decode(request.headers['Authorization'])
        @current_user = @jwt_payload['class'].constantize.find(@jwt_payload['id'])
      rescue StandardError
        render json: { message: 'a' }, status: :unauthorized
      end

      private

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
