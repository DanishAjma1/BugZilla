class ModifyProjectsTable < ActiveRecord::Migration[7.2]
  def change
    # Remove the old column (replace :old_column_name with the actual column name you want to remove)
    remove_column :projects, :manager_id, :datatype # Example: remove_column :projects, :title, :string

    # Add manager_id column as a foreign key
    add_reference :projects, :manager, foreign_key: { to_table: :users }
  end
end
