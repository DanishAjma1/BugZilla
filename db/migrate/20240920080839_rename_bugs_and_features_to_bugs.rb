class RenameBugsAndFeaturesToBugs < ActiveRecord::Migration[7.2]
  def change
    rename_table :bugs_and_features, :bugs
  end
end
