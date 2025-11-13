class UserPolicy < ApplicationPolicy
  def likes?
    @record == @user
  end

  # TODO
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
