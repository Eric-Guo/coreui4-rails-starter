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

  def show?
    user.admin? || record.id == user.id
  end

  def update?
    show?
  end

  def sign_in_as?
    user.admin?
  end
end
