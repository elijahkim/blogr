class PostPolicy < ApplicationPolicy
  def create?
    user.signed_in?
  end

  def update?
    user == record.user
  end

  def destroy?
    update?
  end
end
