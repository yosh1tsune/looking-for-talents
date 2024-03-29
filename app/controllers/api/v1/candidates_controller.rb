# API::V1::CandidatesController
module Api
  module V1
    class CandidatesController < Api::V1::ApiController
      def create
        @candidate = Candidate.create!(candidate_params)

        PublisherService.publish(queue_name: 'confirmation.mailer', payload: confirmation_email_payload)

        render status: :created
      end

      private

      def confirmation_email_payload
        {
          email: @candidate.email,
          confirmation_url: confirmation_url(@candidate, confirmation_token: @candidate.confirmation_token)
      }.to_json
      end

      def candidate_params
        params.require(:candidate).permit(:email, :password)
      end
    end
  end
end
