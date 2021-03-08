class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    # policy scope gives you all thhis items eg. categories.all
    def resolve
      scope.all
    end
  end

  # copy these from application_policy.rb and set to true first
  # once you have set up all applications set to FALSE specific actions
  def index?
    record.user == user
  end

  def create?
    true
  end

  def new?
    create?
  end

  def update?
    true
  end

  def edit?
    update?
  end

  def destroy?
    true
  end
end