class AddImageToBugs < ActiveRecord::Migration[7.2]
  def change
    add_column :bugs, :image, :string
  end
end
