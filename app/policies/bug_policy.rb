class BugPolicy < ApplicationPolicy
   # def index?
   #   user.manager? || user.developer? || user.qa?
   # end
   attr_reader :user, :bug

  def initialize(user, bug)
    @user = user
    @bug = bug
  end

  def assign_bug_to_self?
    user.role == "developer" # Allow only developers to assign bugs to themselves
  end

  def remove_developer?
    true
  end

  # Only the QA who created the bug can update it
  def update?
    if user.developer?
      true
    elsif bug.creator_id == user.id
      true
    else
      false
    end
  end

  def permitted_attributes
    if user.developer?
      [ :status, :deadline ]  # Developer can only update status and deadline
    elsif bug.creator_id == user.id
      [ :title, :description, :status, :type, :deadline, :image, :developer_id ] # QA can update everything
    else
      []
    end
  end

  def create?
    user.qa? && (bug.creator_id == user.id || bug.users.include?(user))
  end

  def destroy?
    bug.creator_id == user.id
  end
end
