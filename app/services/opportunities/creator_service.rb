module Opportunities
  class CreatorService
    attr_reader :user, :attributes

    def initialize(user:, attributes:)
      @user = user
      @attributes = attributes
    end

    def execute
      validate
      user.opportunities.create!(attributes)
    end

    private

    def validate
      Pundit.authorize(user, Opportunity, :create?)
    end
  end
end
