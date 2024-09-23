class RollbackModifyProjectsTable < ActiveRecord::Migration[7.2]
  def change
    add_column :bugs, :project_id, :integer
    add_foreign_key :bugs, :projects, column: :project_id  end
end
