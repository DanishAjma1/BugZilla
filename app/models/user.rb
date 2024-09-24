class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :created_projects, class_name: "Project", foreign_key: "manager_id"  # Projects managed by the user
  has_many :created_bugs, class_name: "Bug", foreign_key: "creator_id", dependent: :destroy
  has_many :assigned_bugs, class_name: "Bug", foreign_key: "developer_id", dependent: :destroy

  validates :role, presence: true, inclusion: { in: %w[manager qa developer] }

  enum role: { qa: 0, developer: 1, manager: 2 }
  has_and_belongs_to_many :assigned_projects, class_name: "Project", dependent: :destroy

  # Scopes to filter users based on role
  scope :qas, -> { where(role: :qa) }
  scope :developers, -> { where(role: :developer) }

  has_and_belongs_to_many :bugs, join_table: :bugs_users

  scope :developers, -> { where(role: "developer") }
end
