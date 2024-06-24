# frozen_string_literal: true

class OpportunityPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.is_a?(Headhunter)
  end

  def new?
    user.is_a?(Headhunter)
  end

  def update?
    record.headhunter == user
  end

  def edit?
    record.headhunter == user
  end

  def destroy?
    record.headhunter == user
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_a?(Headhunter)
        scope.where(headhunter_id: user.id)
      else
        scope.all
      end
    end

    private

    attr_reader :user, :scope
  end
end
