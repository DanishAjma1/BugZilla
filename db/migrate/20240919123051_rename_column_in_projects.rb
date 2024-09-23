class RenameColumnInProjects < ActiveRecord::Migration[7.2]
  def change
    rename_column :projects, :priority, :status
  end
end
