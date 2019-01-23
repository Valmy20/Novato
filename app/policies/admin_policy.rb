class AdminPolicy < ApplicationPolicy
  def index?
    user.full_access?
  end

  def new?
    user.full_access?
  end

  def create?
    user.full_access?
  end

  def edit?
    user.full_access?
  end

  def update?
    user.full_access?
  end

  def destroy?
    user.full_access?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
