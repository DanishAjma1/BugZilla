class Bug < ApplicationRecord
  validates :title, :status, :bug_type, presence: true
    # validates :status, presence: true
    # enum status: { fresh: "Fresh", started: "Started", complete: "Compelete" }
    # validates :status, inclusion: { in: [ "New", "Started", "Compelete", "Resolved" ] }

    enum bug_type: { feature: "feature", bug: "bug" }
    # belongs_to :developer, class_name: "User", foreign_key: "developer_id", optional: true, dependent: :nullify
    belongs_to :project
    mount_uploader :image, ImageUploader
    belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  has_and_belongs_to_many :users, join_table: :bugs_users
end
