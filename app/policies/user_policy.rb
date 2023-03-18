class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(id: user.id)
      end
    end
  end

  def new?
    user.admin?
  end

  def create?
    new?
  end

  def edit?
    user.admin? || record.id == user.id
  end

  def update?
    edit?
  end

  def impersonation?
    user.admin?
  end

  def sign_in_as?
    impersonation?
  end
end
