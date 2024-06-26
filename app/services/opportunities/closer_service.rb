module Opportunities
  class CloserService
    attr_reader :user, :opportunity

    def initialize(user:, opportunity_id:)
      @user = user
      @opportunity = Opportunity.find(opportunity_id)
    end

    def execute
      validate
      opportunity.closed!
      opportunity
    end

    private

    def validate
      Pundit.authorize(user, opportunity, :close?)
    end
  end
end
