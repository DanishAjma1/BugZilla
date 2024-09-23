# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end
 attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  # Check if the user is a manager
  def manager?
    user.role == "manager"
  end

  # Check if the user is a QA
  def qa?
    user.role == "qa"
  end

  # Check if the user is a developer
  def developer?
    user.role == "developer"
  end
end
