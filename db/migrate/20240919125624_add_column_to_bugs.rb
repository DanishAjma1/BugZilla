class AddColumnToBugs < ActiveRecord::Migration[7.2]
  def change
    add_column :bugs_and_features, :deadline, :date
  end
end
