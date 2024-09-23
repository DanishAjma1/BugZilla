class Project < ApplicationRecord
  enum status: { ongoing: "Ongoing", complete: "Completed", onhold: "ON_Hold" }

  belongs_to :manager, class_name: "User", foreign_key: "manager_id"
  has_many :bugs, dependent: :destroy

  has_and_belongs_to_many :users, class_name: "User", dependent: :destroy
  def qas
    users.qas
  end

  def developers
    users.developers
  end
end
