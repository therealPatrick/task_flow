# app/policies/task_policy.rb
class TaskPolicy < ApplicationPolicy
  def index?
    true  # All users can view the task list
  end

  def show?
    user.admin? || record.user == user  # Admins can view all tasks, users can view their own tasks
  end

  def create?
    true  # All users can create tasks
  end

  def update?
    user.admin? || record.user == user  # Admins can update all tasks, users can update their own tasks
  end

  def destroy?
    user.admin? || record.user == user  # Admins can delete all tasks, users can delete their own tasks
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all  # Admins can see all tasks
      else
        scope.where(user: user)  # Regular users can only see their own tasks
      end
    end
  end
end
