class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def index?
    user.manager? || user.developer? || user.qa?
  end

  def show?
    # Check if the user is the project manager
    return true if project.manager_id == user.id || user.qa?

    # Check if the user is a QA or Developer and is assigned to the project
    return true if user.developer? && project.developers.include?(user)

    # Otherwise, deny access
    false
  end

  def create?
    user.manager?
  end

  def update?
    project.manager_id == user.id
  end

  def destroy?
    project.manager_id == user.id
  end
end
