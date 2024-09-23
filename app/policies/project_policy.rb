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
    project.manager_id == user.id  || user.qa? || user.developer?
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
